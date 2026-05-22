import SwiftUI

struct ATECaseStudyBuilderView: View {
    @State private var localAuthority = ""
    @State private var cohort = ""
    @State private var problemStatement = ""
    @State private var baselineModeSplit = "Walk 0% | Cycle 0% | Bus 0% | Car 0%"
    @State private var interventionDesign = "School streets + Walking bus + Cycle training + Bus incentives + Parent nudges"
    @State private var measuredOutcomes = ""
    @State private var equityImpact = ""
    @State private var costEffectiveness = ""
    @State private var scaleReadiness = ""

    private let cards: [EvidenceCard] = [
        .init(name: "School streets", targetBehavior: "Reduce private car drop-off at school gate", mechanism: "Timed traffic restriction at pick-up/drop-off", kpiDelta: "Car share −Xpp; Walk +Xpp", confidence: "Medium", risksMitigations: "Displacement risk → boundary tuning + engagement"),
        .init(name: "Walking bus", targetBehavior: "Shift short-distance car trips to walking", mechanism: "Supervised fixed route with stops/times", kpiDelta: "Walking participants +X/week", confidence: "Medium", risksMitigations: "Volunteer fatigue → rota depth + backup"),
        .init(name: "Cycle training", targetBehavior: "Increase cycling uptake", mechanism: "On/off-road confidence and skills training", kpiDelta: "Cycle share +Xpp", confidence: "Medium", risksMitigations: "Bike access inequality → loan bikes"),
        .init(name: "Bus incentives", targetBehavior: "Shift medium-distance trips from car to bus", mechanism: "Fare relief + clearer eligibility/journey info", kpiDelta: "Bus uptake +X%; Car 2–5km −Xpp", confidence: "Medium", risksMitigations: "Subsidy cliff-edge → tapered support"),
        .init(name: "Parent nudges", targetBehavior: "Increase repeat active choices", mechanism: "Timely prompts + social norm messaging", kpiDelta: "Active trips/household +X", confidence: "Low-Medium", risksMitigations: "Message fatigue → cadence caps + segmentation")
    ]

    var body: some View {
        Form {
            Section("Context / problem") {
                TextField("Local Authority", text: $localAuthority)
                TextField("Cohort", text: $cohort)
                TextField("Problem statement", text: $problemStatement, axis: .vertical)
            }

            Section("Baseline (Before)") {
                TextField("Baseline mode split", text: $baselineModeSplit, axis: .vertical)
            }

            Section("Intervention design (During)") {
                TextField("Intervention package", text: $interventionDesign, axis: .vertical)
            }

            Section("Measured outcomes (After)") {
                TextField("Measured outcomes", text: $measuredOutcomes, axis: .vertical)
            }

            Section("Equity impact") {
                TextField("Equity impact", text: $equityImpact, axis: .vertical)
            }

            Section("Cost-effectiveness") {
                TextField("Cost-effectiveness", text: $costEffectiveness, axis: .vertical)
            }

            Section("Scale-readiness (5 pilot LAs)") {
                TextField("Scale-readiness summary", text: $scaleReadiness, axis: .vertical)
            }

            Section("ATE-aligned headings") {
                headingRow("Mode shift")
                headingRow("Safety perception")
                headingRow("Health outcomes proxy")
                headingRow("Carbon and air-quality co-benefits")
                headingRow("Inclusion/accessibility")
            }

            Section("Evidence cards") {
                ForEach(cards) { card in
                    VStack(alignment: .leading, spacing: 6) {
                        Text(card.name).font(.headline)
                        Text("Target behavior: \(card.targetBehavior)")
                        Text("Mechanism: \(card.mechanism)")
                        Text("KPI delta: \(card.kpiDelta)")
                        Text("Confidence: \(card.confidence)")
                        Text("Risks/mitigations: \(card.risksMitigations)")
                            .foregroundStyle(.secondary)
                    }
                    .padding(.vertical, 4)
                }
            }

            Section("One-page executive summary") {
                Text(executiveSummary)
                    .font(.footnote)
                    .textSelection(.enabled)
            }
        }
        .navigationTitle("ATE Builder")
    }

    private func headingRow(_ title: String) -> some View {
        HStack {
            Image(systemName: "checkmark.seal")
                .foregroundStyle(.accent)
            Text(title)
        }
    }

    private var executiveSummary: String {
        """
        Ask: Approve funding to scale ATE across 5 pilot LAs.

        Context: \(localAuthority.isEmpty ? "[LA]" : localAuthority), cohort \(cohort.isEmpty ? "[cohort]" : cohort).
        Problem: \(problemStatement.isEmpty ? "[problem statement]" : problemStatement)

        Before: \(baselineModeSplit)
        During: \(interventionDesign)
        After: \(measuredOutcomes.isEmpty ? "[measured outcomes]" : measuredOutcomes)

        Equity: \(equityImpact.isEmpty ? "[equity impact]" : equityImpact)
        Cost-effectiveness: \(costEffectiveness.isEmpty ? "[cost summary]" : costEffectiveness)
        Scale-readiness: \(scaleReadiness.isEmpty ? "[readiness summary]" : scaleReadiness)
        """
    }
}

private struct EvidenceCard: Identifiable {
    let id = UUID()
    let name: String
    let targetBehavior: String
    let mechanism: String
    let kpiDelta: String
    let confidence: String
    let risksMitigations: String
}

#Preview {
    NavigationStack {
        ATECaseStudyBuilderView()
    }
}
