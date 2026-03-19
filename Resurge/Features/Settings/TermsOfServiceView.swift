import SwiftUI

struct TermsOfServiceView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: AppStyle.largeSpacing) {
                Text("Terms of Service")
                    .font(Typography.largeTitle)
                    .rainbowText()

                Text("Last updated: March 19, 2026")
                    .font(Typography.caption)
                    .foregroundColor(.textSecondary)

                section(title: "1. Acceptance of Terms", body: """
                These Terms of Service ("Terms") constitute a legally binding agreement between you ("you" or "User") and Thryvenex Holdings LLC ("we," "us," "our," or "Company") governing your use of the LoopRoot mobile application ("LoopRoot" or the "App").

                By downloading, installing, accessing, or using LoopRoot, you acknowledge that you have read, understood, and agree to be bound by these Terms, as well as our Privacy Policy, which is incorporated herein by reference. If you do not agree to these Terms, you must not download, install, or use the App.

                You represent and warrant that you are at least 13 years of age. If you are under 18, you represent that your parent or legal guardian has reviewed and agreed to these Terms on your behalf.
                """)

                section(title: "2. Description of Service", body: """
                LoopRoot is a personal habit tracking and addiction recovery support application that provides tools for tracking sobriety, logging cravings, journaling, setting goals, monitoring progress, earning virtual rewards, and accessing educational recovery content. The App supports recovery programs for smoking, alcohol, pornography, phone usage, social media, gaming, sugar, emotional eating, shopping, and gambling.

                LoopRoot operates entirely offline on your device. There are no user accounts, no servers, no cloud storage, and no internet connection required. All data is stored locally on your device using Apple's Core Data framework and UserDefaults.
                """)

                section(title: "3. NOT Medical Advice -- Important Disclaimer", body: """
                LOOPROOT IS NOT A MEDICAL DEVICE, MEDICAL APPLICATION, OR HEALTHCARE SERVICE. THE APP DOES NOT PROVIDE MEDICAL ADVICE, DIAGNOSIS, TREATMENT, OR THERAPY OF ANY KIND.

                The App is a self-help organizational and motivational tool only. The content, features, tools, health milestones, recovery timelines, coaching plans, educational articles, and all other information within the App are provided for general informational and motivational purposes only and should not be construed as medical, psychological, psychiatric, or therapeutic advice.

                Health recovery milestones displayed in the App (such as physical health improvements after quitting smoking or alcohol) are based on published medical research and general population data. These milestones are approximations and may not accurately reflect your individual health situation, medical history, or recovery trajectory. Individual results vary significantly.

                THE APP IS NOT A SUBSTITUTE FOR PROFESSIONAL MEDICAL ADVICE, DIAGNOSIS, OR TREATMENT. Always seek the advice of a qualified physician, psychiatrist, psychologist, licensed therapist, certified addiction counselor, or other qualified healthcare provider with any questions you may have regarding a medical condition, substance use disorder, behavioral addiction, mental health condition, or treatment plan. Never disregard professional medical advice or delay seeking treatment because of information or features in this App.

                IF YOU ARE EXPERIENCING A MEDICAL EMERGENCY, SUBSTANCE WITHDRAWAL, OVERDOSE, SUICIDAL THOUGHTS, OR ANY OTHER CRISIS, CALL 911 (OR YOUR LOCAL EMERGENCY NUMBER) OR GO TO YOUR NEAREST EMERGENCY ROOM IMMEDIATELY. DO NOT RELY ON THIS APP IN AN EMERGENCY.
                """)

                section(title: "4. Crisis Helpline Disclaimer", body: """
                LoopRoot displays publicly available crisis and support helpline numbers, including but not limited to:

                - SAMHSA National Helpline (1-800-662-4357)
                - National Gambling Helpline (1-800-522-4700)
                - 988 Suicide & Crisis Lifeline (call or text 988)
                - Crisis Text Line (text HOME to 741741)

                These helpline numbers are provided for informational convenience only. Thryvenex Holdings LLC is not affiliated with, endorsed by, or responsible for any of these organizations or services. We do not operate, fund, or control these helplines. We make no representations or warranties regarding the availability, quality, accuracy, or outcomes of any helpline service. Your use of any helpline is entirely at your own discretion and risk, and is governed by the respective organization's terms and policies.
                """)

                section(title: "5. No Liability for Recovery Outcomes", body: """
                Recovery from addiction and habit change is a complex, individual process. Thryvenex Holdings LLC makes no representations, warranties, or guarantees regarding:

                - The effectiveness of the App in helping you achieve or maintain sobriety or behavioral change
                - The accuracy of any streak, progress, health milestone, or statistical data displayed in the App
                - Any particular recovery outcome, health improvement, or behavioral result
                - The suitability of any coaching plan, coping strategy, craving tool, or recovery content for your individual circumstances

                You acknowledge that lapses and relapses are a common part of the recovery process. We are not liable for any lapse, relapse, injury, health consequence, emotional distress, or other adverse outcome that may occur during or after your use of the App, regardless of whether you were following features, suggestions, or tools within the App at the time.
                """)

                section(title: "6. Subscriptions and In-App Purchases", body: """
                LoopRoot offers optional premium features through auto-renewable subscriptions and a one-time lifetime purchase, processed entirely by Apple through the App Store.

                Subscription Options:
                - Monthly: $4.99 USD per month (auto-renewable)
                - Yearly: $39.99 USD per year (auto-renewable)
                - Lifetime: $99.99 USD (one-time, non-recurring purchase)

                Payment Terms:
                - Payment is charged to your Apple ID account upon confirmation of purchase.
                - Auto-renewable subscriptions automatically renew at the end of each billing period unless you cancel at least 24 hours before the end of the current period.
                - Your account will be charged for renewal within 24 hours prior to the end of the current billing period at the rate of your selected plan.
                - You may manage or cancel your subscriptions at any time through your Apple ID account settings (Settings > [your name] > Subscriptions on your iOS device).
                - Cancellation takes effect at the end of the current billing period. You will continue to have access to premium features until the end of your paid period.
                - The Lifetime purchase provides permanent access to premium features and does not renew.

                Free Trial:
                - If a free trial is offered, any unused portion of the trial period will be forfeited when you purchase a subscription.

                Price Changes:
                - Prices are subject to change. We will provide notice of any price changes through the App or App Store. Continued subscription after a price change constitutes acceptance of the new price.
                """)

                section(title: "7. Refund Policy", body: """
                All purchases are processed by Apple. Refund requests must be directed to Apple in accordance with Apple's refund policies. You may request a refund through Apple's "Report a Problem" page (https://reportaproblem.apple.com) or by contacting Apple Support.

                Thryvenex Holdings LLC does not process payments and cannot issue refunds directly. We will cooperate with Apple on any refund-related inquiries.
                """)

                section(title: "8. Free Tier", body: """
                The free version of LoopRoot includes tracking for one (1) habit, daily check-ins (morning, afternoon, evening), one (1) daily motivational quote, journal access, craving tools, basic achievement badges, and the ability to earn Surges (in-app virtual currency, up to 15 per day).

                Premium features -- including unlimited habits, advanced analytics, coaching plans, additional daily quotes, and all unlockable badges -- require a paid subscription or lifetime purchase.

                We reserve the right to modify the features included in the free and premium tiers at any time.
                """)

                section(title: "9. Virtual Currency and In-App Items", body: """
                LoopRoot features a virtual currency called "Surges" and virtual items including companion pets (Pup, Kitten, Nibbles, Owlet), accessories (Tiny Hat, Cool Glasses, Royal Crown, Bowtie), celebration packs, power-ups, and visual themes.

                Surges and all virtual items:
                - Have no real-world monetary value and cannot be exchanged for real currency, goods, or services
                - Are non-transferable and cannot be sold, traded, or given to other users
                - Are stored locally on your device and will be lost if you delete the App without creating a backup
                - Are earned through in-app activities (daily check-ins) and spent within the Vault Shop
                - May be modified, rebalanced, or discontinued at our discretion

                We are not liable for any loss of virtual currency or virtual items due to device failure, App deletion, software updates, or any other cause.
                """)

                section(title: "10. User Data and Responsibility", body: """
                All data created within LoopRoot is stored exclusively on your device. You are solely responsible for:

                - Maintaining and safeguarding your device and the data stored on it
                - Creating and securely storing encrypted backups of your data if you wish to preserve it
                - Protecting access to the App (using the optional privacy lock feature, device passcode, etc.)
                - Any consequences of deleting the App, resetting your device, or losing your device

                Because LoopRoot does not store your data on any server, WE CANNOT RECOVER, RESTORE, OR RETRIEVE YOUR DATA UNDER ANY CIRCUMSTANCES. If you delete the App, lose your device, or otherwise lose access to your locally stored data without having created a backup, your data is permanently and irretrievably lost. You acknowledge and accept this risk.
                """)

                section(title: "11. Encrypted Backup", body: """
                LoopRoot provides an optional encrypted backup feature using AES-256 encryption. You are solely responsible for your backup files and encryption passwords. If you lose your encryption password, we cannot recover it or decrypt your backup. We make no guarantees regarding the integrity, compatibility, or recoverability of backup files across App versions or devices.
                """)

                section(title: "12. Intellectual Property", body: """
                All content, features, functionality, design, graphics, user interface, visual elements, animations, text, code, companion pet designs and artwork, badge designs, theme designs, the Surge economy system, the LoopRoot name, the "Escape the loop. Find your root." tagline, and all other materials within LoopRoot (collectively, "App Content") are the exclusive property of Thryvenex Holdings LLC and are protected by United States and international copyright, trademark, trade dress, patent, and other intellectual property laws.

                You are granted a limited, non-exclusive, non-transferable, revocable license to use the App for your personal, non-commercial use in accordance with these Terms. You may not:

                - Copy, reproduce, modify, adapt, translate, or create derivative works of the App or App Content
                - Reverse engineer, decompile, disassemble, or attempt to derive the source code of the App
                - Distribute, sublicense, lease, rent, loan, or otherwise transfer the App or any rights therein
                - Remove, alter, or obscure any copyright, trademark, or other proprietary notices in the App
                - Use the App Content for any commercial purpose without our express written consent
                - Use any automated means (bots, scrapers, etc.) to access or interact with the App
                - Attempt to circumvent any security features, entitlement checks, or premium gating within the App
                """)

                section(title: "13. Disclaimer of Warranties", body: """
                TO THE MAXIMUM EXTENT PERMITTED BY APPLICABLE LAW, LOOPROOT IS PROVIDED ON AN "AS IS" AND "AS AVAILABLE" BASIS WITHOUT WARRANTIES OF ANY KIND, WHETHER EXPRESS, IMPLIED, STATUTORY, OR OTHERWISE.

                THRYVENEX HOLDINGS LLC EXPRESSLY DISCLAIMS ALL WARRANTIES, INCLUDING BUT NOT LIMITED TO:

                - IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, AND NON-INFRINGEMENT
                - WARRANTIES ARISING FROM COURSE OF DEALING, USAGE, OR TRADE PRACTICE
                - ANY WARRANTY THAT THE APP WILL BE UNINTERRUPTED, ERROR-FREE, SECURE, OR FREE OF VIRUSES OR HARMFUL COMPONENTS
                - ANY WARRANTY REGARDING THE ACCURACY, RELIABILITY, OR COMPLETENESS OF ANY CONTENT, HEALTH MILESTONES, RECOVERY TIMELINES, OR OTHER INFORMATION IN THE APP
                - ANY WARRANTY REGARDING THE RESULTS THAT MAY BE OBTAINED FROM USE OF THE APP

                Some jurisdictions do not allow the exclusion of implied warranties, so some or all of the above exclusions may not apply to you. In such jurisdictions, our liability is limited to the fullest extent permitted by law.
                """)

                section(title: "14. Limitation of Liability", body: """
                TO THE MAXIMUM EXTENT PERMITTED BY APPLICABLE LAW, IN NO EVENT SHALL THRYVENEX HOLDINGS LLC, ITS OFFICERS, DIRECTORS, MEMBERS, EMPLOYEES, AGENTS, AFFILIATES, SUCCESSORS, OR ASSIGNS BE LIABLE FOR ANY:

                - INDIRECT, INCIDENTAL, SPECIAL, CONSEQUENTIAL, EXEMPLARY, OR PUNITIVE DAMAGES
                - LOSS OF PROFITS, REVENUE, DATA, GOODWILL, OR OTHER INTANGIBLE LOSSES
                - DAMAGES ARISING FROM YOUR USE OF OR INABILITY TO USE THE APP
                - DAMAGES ARISING FROM ANY CONTENT, HEALTH MILESTONES, OR INFORMATION OBTAINED THROUGH THE APP
                - DAMAGES ARISING FROM UNAUTHORIZED ACCESS TO OR ALTERATION OF YOUR DATA
                - DAMAGES ARISING FROM ANY LAPSE, RELAPSE, OR RECOVERY OUTCOME
                - DAMAGES ARISING FROM YOUR RELIANCE ON ANY FEATURE, TOOL, OR CONTENT IN THE APP
                - PERSONAL INJURY OR PROPERTY DAMAGE RELATED TO YOUR USE OF THE APP

                WHETHER BASED ON WARRANTY, CONTRACT, TORT (INCLUDING NEGLIGENCE), STRICT LIABILITY, OR ANY OTHER LEGAL THEORY, AND WHETHER OR NOT WE HAVE BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES.

                IN ANY EVENT, OUR TOTAL AGGREGATE LIABILITY TO YOU FOR ALL CLAIMS ARISING OUT OF OR RELATING TO THESE TERMS OR YOUR USE OF THE APP SHALL NOT EXCEED THE GREATER OF (A) THE AMOUNT YOU ACTUALLY PAID US FOR THE APP IN THE TWELVE (12) MONTHS PRECEDING THE CLAIM, OR (B) FIFTY DOLLARS ($50.00 USD).

                Some jurisdictions do not allow the limitation or exclusion of liability for certain damages, so some of the above limitations may not apply to you. In such jurisdictions, our liability is limited to the fullest extent permitted by law.
                """)

                section(title: "15. Indemnification", body: """
                You agree to indemnify, defend, and hold harmless Thryvenex Holdings LLC, its officers, directors, members, employees, agents, affiliates, successors, and assigns from and against any and all claims, damages, losses, liabilities, costs, and expenses (including reasonable attorneys' fees and court costs) arising out of or relating to:

                - Your use of or access to the App
                - Your violation of these Terms
                - Your violation of any applicable law, regulation, or third-party right
                - Any content or data you create, store, or export through the App
                - Any claim that your use of the App caused damage to a third party

                This indemnification obligation shall survive the termination of these Terms and your use of the App.
                """)

                section(title: "16. Termination", body: """
                These Terms are effective until terminated. You may terminate these Terms at any time by deleting the App and all copies thereof from your device(s).

                We reserve the right to modify, suspend, or discontinue the App (or any part thereof) at any time, with or without notice, for any reason. We shall not be liable to you or any third party for any modification, suspension, or discontinuation of the App.

                Upon termination:
                - Your license to use the App is immediately revoked
                - You must delete all copies of the App from your device(s)
                - Sections of these Terms that by their nature should survive termination (including but not limited to Sections 3, 5, 12, 13, 14, 15, 17, 18, 19, and 20) shall survive

                Termination does not affect any active Apple subscription. You must separately cancel any subscription through your Apple ID account settings to avoid future charges.
                """)

                section(title: "17. Governing Law and Dispute Resolution", body: """
                These Terms shall be governed by and construed in accordance with the laws of the State of Delaware, United States, without regard to its conflict of law principles.

                Any dispute, claim, or controversy arising out of or relating to these Terms or your use of the App shall be resolved exclusively in the state or federal courts located in the State of Delaware. You hereby consent to the personal jurisdiction of such courts and waive any objection to venue in such courts.

                To the extent permitted by applicable law, you agree that any claim or cause of action arising out of or relating to these Terms or the App must be filed within one (1) year after such claim or cause of action arose, or be forever barred.
                """)

                section(title: "18. Apple-Specific Terms (End User License Agreement)", body: """
                These Terms are between you and Thryvenex Holdings LLC, and not with Apple Inc. ("Apple"). Apple is not responsible for the App or its content.

                In accordance with Apple's requirements, you acknowledge and agree to the following:

                a) License Scope: The license granted to you for the App is a limited, non-transferable license to use the App on any Apple-branded device that you own or control, as permitted by the Usage Rules set forth in the Apple Media Services Terms and Conditions.

                b) Maintenance and Support: Thryvenex Holdings LLC is solely responsible for providing any maintenance and support services for the App, as specified in these Terms or as required under applicable law. Apple has no obligation to furnish any maintenance and support services with respect to the App.

                c) Warranty: Thryvenex Holdings LLC is solely responsible for any product warranties, whether express or implied by law, to the extent not effectively disclaimed. In the event of any failure of the App to conform to any applicable warranty, you may notify Apple, and Apple will refund the purchase price (if any) for the App. To the maximum extent permitted by applicable law, Apple has no other warranty obligation with respect to the App.

                d) Product Claims: Thryvenex Holdings LLC, and not Apple, is responsible for addressing any claims relating to the App or your possession and/or use of the App, including but not limited to: (i) product liability claims; (ii) any claim that the App fails to conform to any applicable legal or regulatory requirement; and (iii) claims arising under consumer protection, privacy, or similar legislation.

                e) Intellectual Property Claims: In the event of any third-party claim that the App or your possession and use of the App infringes a third party's intellectual property rights, Thryvenex Holdings LLC, and not Apple, shall be solely responsible for the investigation, defense, settlement, and discharge of any such claim.

                f) Legal Compliance: You represent and warrant that (i) you are not located in a country that is subject to a U.S. Government embargo or that has been designated by the U.S. Government as a "terrorist supporting" country; and (ii) you are not listed on any U.S. Government list of prohibited or restricted parties.

                g) Third-Party Beneficiary: Apple and its subsidiaries are third-party beneficiaries of these Terms. Upon your acceptance of these Terms, Apple will have the right (and will be deemed to have accepted the right) to enforce these Terms against you as a third-party beneficiary thereof.

                h) Apple Contact: If you have any questions, complaints, or claims regarding the App, please contact Thryvenex Holdings LLC at support@placeholder.com. For general Apple inquiries, contact Apple at https://www.apple.com/legal/internet-services/itunes/.
                """)

                section(title: "19. Severability", body: """
                If any provision of these Terms is held to be invalid, illegal, or unenforceable by a court of competent jurisdiction, such provision shall be modified to the minimum extent necessary to make it valid, legal, and enforceable, or if modification is not possible, shall be severed from these Terms. The invalidity of any provision shall not affect the validity or enforceability of the remaining provisions, which shall continue in full force and effect.
                """)

                section(title: "20. Entire Agreement and Waiver", body: """
                These Terms, together with our Privacy Policy, constitute the entire agreement between you and Thryvenex Holdings LLC with respect to your use of the App and supersede all prior or contemporaneous communications, proposals, and agreements, whether oral or written, between you and us regarding the App.

                No waiver of any provision of these Terms shall be deemed a further or continuing waiver of such provision or any other provision. Our failure to assert any right or provision under these Terms shall not constitute a waiver of such right or provision.
                """)

                section(title: "21. Assignment", body: """
                You may not assign or transfer these Terms or any rights or obligations hereunder, in whole or in part, without our prior written consent. We may assign or transfer these Terms, in whole or in part, without restriction and without notice to you. Subject to the foregoing, these Terms shall bind and inure to the benefit of the parties and their respective successors and assigns.
                """)

                section(title: "22. Changes to These Terms", body: """
                We reserve the right to modify, amend, or update these Terms at any time at our sole discretion. Any changes will be reflected within the App with an updated effective date. Your continued use of the App after the posting of revised Terms constitutes your acceptance of and agreement to the revised Terms. If you do not agree to the revised Terms, you must stop using the App.

                We encourage you to review these Terms periodically for any changes.
                """)

                section(title: "23. Contact Us", body: """
                If you have any questions, concerns, or feedback regarding these Terms of Service, please contact us at:

                Thryvenex Holdings LLC
                Email: support@placeholder.com
                """)
            }
            .padding(AppStyle.screenPadding)
        }
        .background(Color.appBackground.ignoresSafeArea())
        .navigationTitle("Terms of Service")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func section(title: String, body: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(Typography.headline)
                .foregroundColor(.textPrimary)

            Text(body)
                .font(Typography.body)
                .foregroundColor(.textSecondary)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}
