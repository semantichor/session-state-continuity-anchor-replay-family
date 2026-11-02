function load_ct_oracles(    n) {
    delete ct_verdicts
    ct_verdicts[1]="REPLAY_ADMISSIBLE"
    ct_verdicts[2]="REPLAY_ADMISSIBLE_CONSTRAINED"
    ct_verdicts[3]="REPLAY_INCOMPLETE"
    ct_verdicts[4]="NONCOMPLIANT_HOLD"
    ct_verdicts[5]="CONTAMINATION_FAIL_CLOSED"
    ct_verdicts[6]="INCIDENT_ONLY"
    return 6
}
function ct_verdict_allowed(value,    i,n) {
    n=load_ct_oracles()
    for(i=1;i<=n;i++) if(ct_verdicts[i]==value) return 1
    return 0
}
