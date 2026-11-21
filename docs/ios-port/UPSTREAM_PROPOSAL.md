# Draft proposal to Alternate upstream — DO NOT POST YET

**Subject:** RFC: optional Kotlin Multiplatform shared core with incremental iOS caller identification

Hello! I've been using Alternate's design as the basis for a second, fully private address book on iPhone, and I'd like to contribute to the project rather than keep a disconnected fork.

I noticed v3 is native Kotlin/Jetpack Compose with Room, and the existing Android caller detection and overlays are well scoped. I'd like to explore an **incremental Kotlin Multiplatform extraction** to reuse portable contact, phone, search, vCard and eventually Room/domain code across Android and iOS. The iOS side would use a small Swift Call Directory extension for offline name/number caller identification, rather than trying to reproduce Android overlays or ask for Phone/Contacts permissions iOS cannot provide.

My priority is **zero Android regressions**: preserve package identity, schema/migrations, existing 2.x upgrade behavior, current UI and release process. The changes would be split into independently reviewed, reversible PRs, each with Android tests. No change to your design or build system would be proposed as a single sweeping rewrite.

Would you be open to discussing KMP for shared domain/database code and an optional iOS target, or would you prefer iOS work kept separate in a fork? If KMP is of interest, I can prepare a small model/utility extraction and compile/test spike first for feedback.

Thank you for maintaining Alternate.

---

**Not sent.** Owner should approve language and confirm upstream has not adopted a conflicting roadmap before contact. No upstream issues or PRs authorized as part of planning.