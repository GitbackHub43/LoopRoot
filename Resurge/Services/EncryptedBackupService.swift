import Foundation
import CryptoKit
import CoreData

struct EncryptedBackupService {

    // MARK: - Export

    static func exportBackup(context: NSManagedObjectContext, passphrase: String) throws -> Data {
        let formatter = ISO8601DateFormatter()
        var backup: [String: Any] = [:]
        backup["version"] = 1
        backup["appName"] = "LoopRoot"
        backup["exportedAt"] = formatter.string(from: Date())

        // MARK: Habits
        let habitRequest: NSFetchRequest<CDHabit> = NSFetchRequest(entityName: "CDHabit")
        let habits = (try? context.fetch(habitRequest)) ?? []
        backup["habits"] = habits.map { h -> [String: Any] in
            var dict: [String: Any] = [
                "id": h.id.uuidString,
                "name": h.name,
                "programType": h.programType,
                "startDate": formatter.string(from: h.startDate),
                "goalDays": h.goalDays,
                "isActive": h.isActive,
                "sortOrder": h.sortOrder,
                "baselineCostPerDay": h.baselineCostPerDay,
                "baselineTimePerDay": h.baselineTimePerDay,
                "costPerUnit": h.costPerUnit,
                "timePerUnit": h.timePerUnit,
                "dailyUnits": h.dailyUnits
            ]
            if let reason = h.reasonToQuit { dict["reasonToQuit"] = reason }
            dict["createdAt"] = formatter.string(from: h.createdAt)
            return dict
        }

        // MARK: Daily Log Entries
        let logRequest: NSFetchRequest<CDDailyLogEntry> = NSFetchRequest(entityName: "CDDailyLogEntry")
        let logs = (try? context.fetch(logRequest)) ?? []
        backup["dailyLogs"] = logs.map { e -> [String: Any] in
            var dict: [String: Any] = [
                "date": formatter.string(from: e.date),
                "mood": e.mood,
                "didReflect": e.didReflect,
                "didPledge": e.didPledge,
                "lapsedToday": e.lapsedToday,
                "entryType": e.entryType ?? "unknown"
            ]
            dict["habitId"] = e.habit?.id.uuidString ?? ""
            if let text = e.pledgeText { dict["pledgeText"] = text }
            if let text = e.reflectionText { dict["reflectionText"] = text }
            if let text = e.wins { dict["wins"] = text }
            if let text = e.lapseNotes { dict["lapseNotes"] = text }
            if let text = e.planForTomorrow { dict["planForTomorrow"] = text }
            if let text = e.gratitudeText { dict["gratitudeText"] = text }
            if let tags = e.tags { dict["tags"] = tags }
            dict["createdAt"] = formatter.string(from: e.createdAt)
            return dict
        }

        // MARK: Journal Entries
        let journalRequest: NSFetchRequest<CDJournalEntry> = NSFetchRequest(entityName: "CDJournalEntry")
        let journals = (try? context.fetch(journalRequest)) ?? []
        backup["journals"] = journals.map { j -> [String: Any] in
            var dict: [String: Any] = [
                "id": j.id.uuidString,
                "mood": j.mood,
                "body": j.body,
                "createdAt": formatter.string(from: j.createdAt)
            ]
            dict["habitId"] = j.habit?.id.uuidString ?? ""
            if let title = j.title { dict["title"] = title }
            if let prompt = j.promptUsed { dict["promptUsed"] = prompt }
            return dict
        }

        // MARK: Craving Entries
        let cravingRequest: NSFetchRequest<CDCravingEntry> = NSFetchRequest(entityName: "CDCravingEntry")
        let cravings = (try? context.fetch(cravingRequest)) ?? []
        backup["cravings"] = cravings.map { c -> [String: Any] in
            var dict: [String: Any] = [
                "id": c.id.uuidString,
                "intensity": c.intensity,
                "didResist": c.didResist,
                "timestamp": formatter.string(from: c.timestamp)
            ]
            dict["habitId"] = c.habit?.id.uuidString ?? ""
            if let trigger = c.triggerCategory { dict["triggerCategory"] = trigger }
            if let tool = c.copingToolUsed { dict["copingToolUsed"] = tool }
            if let note = c.triggerNote { dict["triggerNote"] = note }
            return dict
        }

        // MARK: Achievement Unlocks
        let achieveRequest: NSFetchRequest<CDAchievementUnlock> = NSFetchRequest(entityName: "CDAchievementUnlock")
        let achieves = (try? context.fetch(achieveRequest)) ?? []
        backup["achievements"] = achieves.map { a -> [String: Any] in
            var dict: [String: Any] = [
                "achievementKey": a.achievementKey,
                "unlockedAt": formatter.string(from: a.unlockedAt)
            ]
            dict["habitId"] = a.habit?.id.uuidString ?? ""
            return dict
        }

        // MARK: UserDefaults Settings
        let defaults = UserDefaults.standard
        var settings: [String: Any] = [:]
        settings["shardBalance"] = defaults.integer(forKey: "shardBalance")
        settings["selectedTheme"] = defaults.string(forKey: "selectedTheme") ?? "default"
        settings["activePet"] = defaults.string(forKey: "activePet") ?? ""
        settings["equippedAccessories"] = defaults.string(forKey: "equippedAccessories") ?? ""
        settings["equippedWatchSkin"] = defaults.string(forKey: "equippedWatchSkin") ?? ""
        settings["purchasedVaultItems"] = defaults.string(forKey: "purchasedVaultItems") ?? ""
        settings["isPremium"] = defaults.bool(forKey: "isPremium")
        settings["wakeUpHour"] = defaults.integer(forKey: "wakeUpHour")
        settings["morningLoopHour"] = defaults.integer(forKey: "morningLoopHour")
        settings["morningLoopMinute"] = defaults.integer(forKey: "morningLoopMinute")
        settings["afternoonLoopHour"] = defaults.integer(forKey: "afternoonLoopHour")
        settings["afternoonLoopMinute"] = defaults.integer(forKey: "afternoonLoopMinute")
        settings["eveningLoopHour"] = defaults.integer(forKey: "eveningLoopHour")
        settings["eveningLoopMinute"] = defaults.integer(forKey: "eveningLoopMinute")
        backup["settings"] = settings

        // Serialize to JSON
        let jsonData = try JSONSerialization.data(withJSONObject: backup, options: [.sortedKeys])

        // Derive key from passphrase using SHA256
        let keyData = SHA256.hash(data: Data(passphrase.utf8))
        let key = SymmetricKey(data: keyData)

        // Encrypt with AES-256-GCM
        let sealedBox = try AES.GCM.seal(jsonData, using: key)
        guard let combined = sealedBox.combined else {
            throw NSError(domain: "Backup", code: 1, userInfo: [NSLocalizedDescriptionKey: "Encryption failed"])
        }
        return combined
    }

    // MARK: - Import

    static func importBackup(data: Data, passphrase: String, context: NSManagedObjectContext) throws {
        // Decrypt
        let keyData = SHA256.hash(data: Data(passphrase.utf8))
        let key = SymmetricKey(data: keyData)
        let sealedBox = try AES.GCM.SealedBox(combined: data)
        let decryptedData = try AES.GCM.open(sealedBox, using: key)

        guard let json = try JSONSerialization.jsonObject(with: decryptedData) as? [String: Any] else {
            throw NSError(domain: "Backup", code: 2, userInfo: [NSLocalizedDescriptionKey: "Invalid backup format"])
        }

        guard json["appName"] as? String == "LoopRoot" else {
            throw NSError(domain: "Backup", code: 3, userInfo: [NSLocalizedDescriptionKey: "Not a LoopRoot backup file"])
        }

        let formatter = ISO8601DateFormatter()

        // MARK: Wipe Existing Data (fetch and delete individually to keep context in sync)
        let entityNames = ["CDAchievementUnlock", "CDCravingEntry", "CDJournalEntry", "CDDailyLogEntry", "CDIfThenPlan", "CDCoachingPlan", "CDHabit"]
        for entityName in entityNames {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
            let existing = (try? context.fetch(fetchRequest)) ?? []
            for obj in existing {
                context.delete(obj)
            }
        }
        try context.save()

        // MARK: Restore Habits
        if let habitsArray = json["habits"] as? [[String: Any]] {
            for h in habitsArray {
                guard let name = h["name"] as? String,
                      let programType = h["programType"] as? String,
                      let startDateStr = h["startDate"] as? String,
                      let startDate = formatter.date(from: startDateStr) else { continue }

                let habit = CDHabit(context: context)
                if let idStr = h["id"] as? String, let id = UUID(uuidString: idStr) {
                    habit.id = id
                } else {
                    habit.id = UUID()
                }
                habit.name = name
                habit.programType = programType
                habit.startDate = startDate
                habit.goalDays = (h["goalDays"] as? Int32) ?? 30
                habit.isActive = (h["isActive"] as? Bool) ?? true
                habit.sortOrder = (h["sortOrder"] as? Int16) ?? 0
                habit.baselineCostPerDay = (h["baselineCostPerDay"] as? Double) ?? 0
                habit.baselineTimePerDay = (h["baselineTimePerDay"] as? Double) ?? 0
                habit.costPerUnit = (h["costPerUnit"] as? Double) ?? 0
                habit.timePerUnit = (h["timePerUnit"] as? Double) ?? 0
                habit.dailyUnits = (h["dailyUnits"] as? Double) ?? 0
                habit.reasonToQuit = h["reasonToQuit"] as? String
                if let ca = h["createdAt"] as? String, let caDate = formatter.date(from: ca) { habit.createdAt = caDate } else { habit.createdAt = Date() }
                habit.updatedAt = Date()
            }
        }

        // MARK: Restore Daily Logs
        if let logsArray = json["dailyLogs"] as? [[String: Any]] {
            // Build habit lookup from restored context
            let habitRequest: NSFetchRequest<CDHabit> = NSFetchRequest(entityName: "CDHabit")
            let allHabits = (try? context.fetch(habitRequest)) ?? []
            let habitMap = Dictionary(uniqueKeysWithValues: allHabits.map { ($0.id.uuidString, $0) })

            for l in logsArray {
                guard let dateStr = l["date"] as? String,
                      let date = formatter.date(from: dateStr) else { continue }

                let entry = CDDailyLogEntry(context: context)
                entry.date = date
                entry.mood = (l["mood"] as? Int16) ?? 0
                entry.didReflect = (l["didReflect"] as? Bool) ?? false
                entry.didPledge = (l["didPledge"] as? Bool) ?? false
                entry.lapsedToday = (l["lapsedToday"] as? Bool) ?? false
                entry.entryType = l["entryType"] as? String
                entry.pledgeText = l["pledgeText"] as? String
                entry.reflectionText = l["reflectionText"] as? String
                entry.wins = l["wins"] as? String
                entry.lapseNotes = l["lapseNotes"] as? String
                entry.planForTomorrow = l["planForTomorrow"] as? String
                entry.gratitudeText = l["gratitudeText"] as? String
                entry.tags = l["tags"] as? String
                if let ca = l["createdAt"] as? String, let caDate = formatter.date(from: ca) { entry.createdAt = caDate } else { entry.createdAt = date }
                if let hid = l["habitId"] as? String { entry.habit = habitMap[hid] }
            }
        }

        // MARK: Restore Journals
        if let journalsArray = json["journals"] as? [[String: Any]] {
            let habitRequest: NSFetchRequest<CDHabit> = NSFetchRequest(entityName: "CDHabit")
            let allHabits = (try? context.fetch(habitRequest)) ?? []
            let habitMap = Dictionary(uniqueKeysWithValues: allHabits.map { ($0.id.uuidString, $0) })

            for j in journalsArray {
                let entry = CDJournalEntry(context: context)
                if let idStr = j["id"] as? String { entry.id = UUID(uuidString: idStr) ?? UUID() } else { entry.id = UUID() }
                entry.title = j["title"] as? String
                entry.body = (j["body"] as? String) ?? ""
                entry.mood = (j["mood"] as? Int16) ?? 0
                entry.promptUsed = j["promptUsed"] as? String
                entry.date = Date()
                if let ca = j["createdAt"] as? String, let caDate = formatter.date(from: ca) { entry.createdAt = caDate; entry.date = caDate } else { entry.createdAt = Date() }
                entry.updatedAt = Date()
                if let hid = j["habitId"] as? String { entry.habit = habitMap[hid] }
            }
        }

        // MARK: Restore Cravings
        if let cravingsArray = json["cravings"] as? [[String: Any]] {
            let habitRequest: NSFetchRequest<CDHabit> = NSFetchRequest(entityName: "CDHabit")
            let allHabits = (try? context.fetch(habitRequest)) ?? []
            let habitMap = Dictionary(uniqueKeysWithValues: allHabits.map { ($0.id.uuidString, $0) })

            for c in cravingsArray {
                let entry = CDCravingEntry(context: context)
                if let idStr = c["id"] as? String { entry.id = UUID(uuidString: idStr) ?? UUID() } else { entry.id = UUID() }
                entry.intensity = (c["intensity"] as? Int16) ?? 0
                entry.didResist = (c["didResist"] as? Bool) ?? false
                entry.triggerCategory = c["triggerCategory"] as? String
                entry.copingToolUsed = c["copingToolUsed"] as? String
                entry.triggerNote = c["triggerNote"] as? String
                entry.eventType = "CRAVING"
                entry.outcome = entry.didResist ? "resisted" : "gave_in"
                if let ts = c["timestamp"] as? String, let tsDate = formatter.date(from: ts) { entry.timestamp = tsDate } else { entry.timestamp = Date() }
                if let hid = c["habitId"] as? String { entry.habit = habitMap[hid] }
            }
        }

        // MARK: Restore Achievements
        if let achievesArray = json["achievements"] as? [[String: Any]] {
            let habitRequest: NSFetchRequest<CDHabit> = NSFetchRequest(entityName: "CDHabit")
            let allHabits = (try? context.fetch(habitRequest)) ?? []
            let habitMap = Dictionary(uniqueKeysWithValues: allHabits.map { ($0.id.uuidString, $0) })

            for a in achievesArray {
                guard let key = a["achievementKey"] as? String else { continue }
                let unlock = CDAchievementUnlock(context: context)
                unlock.id = UUID()
                unlock.achievementKey = key
                if let date = a["unlockedAt"] as? String, let d = formatter.date(from: date) { unlock.unlockedAt = d } else { unlock.unlockedAt = Date() }
                if let hid = a["habitId"] as? String { unlock.habit = habitMap[hid] }
            }
        }

        // MARK: Restore Settings
        if let settings = json["settings"] as? [String: Any] {
            let defaults = UserDefaults.standard
            if let v = settings["shardBalance"] as? Int { defaults.set(v, forKey: "shardBalance") }
            if let v = settings["selectedTheme"] as? String { defaults.set(v, forKey: "selectedTheme") }
            if let v = settings["activePet"] as? String { defaults.set(v, forKey: "activePet") }
            if let v = settings["equippedAccessories"] as? String { defaults.set(v, forKey: "equippedAccessories") }
            if let v = settings["equippedWatchSkin"] as? String { defaults.set(v, forKey: "equippedWatchSkin") }
            if let v = settings["purchasedVaultItems"] as? String { defaults.set(v, forKey: "purchasedVaultItems") }
            if let v = settings["wakeUpHour"] as? Int { defaults.set(v, forKey: "wakeUpHour") }
            if let v = settings["morningLoopHour"] as? Int { defaults.set(v, forKey: "morningLoopHour") }
            if let v = settings["morningLoopMinute"] as? Int { defaults.set(v, forKey: "morningLoopMinute") }
            if let v = settings["afternoonLoopHour"] as? Int { defaults.set(v, forKey: "afternoonLoopHour") }
            if let v = settings["afternoonLoopMinute"] as? Int { defaults.set(v, forKey: "afternoonLoopMinute") }
            if let v = settings["eveningLoopHour"] as? Int { defaults.set(v, forKey: "eveningLoopHour") }
            if let v = settings["eveningLoopMinute"] as? Int { defaults.set(v, forKey: "eveningLoopMinute") }
        }

        // Save context
        try context.save()
    }
}
