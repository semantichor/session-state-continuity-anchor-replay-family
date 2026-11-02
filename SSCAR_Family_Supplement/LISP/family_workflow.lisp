(defparameter *states* '("S0" "S1" "S2" "S3" "S4" "S5" "S6" "S7" "S8" "SH" "SR" "SX"))
(defparameter *triggers*
  '("Fv01Pass" "Admission" "Fv02AndFv04Pass" "BoundaryScreening" "Fv03Pass"
    "ProvenanceClassification" "Fv05AndFv06Pass" "AcceptedHeadFreshnessLock"
    "Fv07Pass" "VerifiedRehydrationClosure" "Fv08Pass" "ReplayReconstruction" "ReplayAdmissibleClosure"
    "Fv10AndFv11Pass" "FamilyReportAssembly" "FamilyVerdictIssued" "EmitFamilyVerdict"
    "FreshnessReplay" "CriticalContamination" "AntiRollbackFailure" "ChainBreak"
    "UntrustedAnchorPromoted" "UnlabeledMechanismLevelCarriedClaim"
    "RemediableFailureOfFv06OrFv12" "HoldCaseWithNewFamilyClosureBundleAndAnchorUpdate"
    "ReadmissionReview" "ReadmissionBundleChangedCarriedPayload"
    "ReadmissionBundleChangedAnchorDocumentRef" "ReadmissionBundleChangedSourceControlBundles"
    "ReadmissionBundleChangedPolicySnapshotId" "ReadmissionBundleChangedRehydrationClosureRef"
    "Handoff" "IncidentOnlyOutput"))

(defun next-state (state trigger passed)
  (cond
    ((string= trigger "CriticalContamination") "SX")
    ((and (string= trigger "UnlabeledMechanismLevelCarriedClaim") (string= state "S2")) "SX")
    ((and (string= trigger "AntiRollbackFailure") (string= state "S5")) "SX")
    ((and (member trigger '("ChainBreak" "UntrustedAnchorPromoted") :test #'string=) (string= state "S3")) "SX")
    ((and (string= trigger "FreshnessReplay") (string= state "S3")) "SH")
    ((and (string= trigger "RemediableFailureOfFv06OrFv12") (string= state "S3")) "SH")
     ((and (string= trigger "Fv02AndFv04Pass") (string= state "S1") (not passed)) "SX")
     ((and (string= trigger "Fv03Pass") (string= state "S2") (not passed)) "SX")
     ((and (string= trigger "Fv07Pass") (string= state "S4") (not passed)) "SX")
    ((not passed) state)
    ((and (string= state "S0") (member trigger '("Fv01Pass" "Admission") :test #'string=)) "S1")
    ((and (string= state "S1") (member trigger '("Fv02AndFv04Pass" "BoundaryScreening") :test #'string=)) "S2")
    ((and (string= state "S2") (member trigger '("Fv03Pass" "ProvenanceClassification") :test #'string=)) "S3")
    ((and (string= state "S3") (member trigger '("Fv05AndFv06Pass" "AcceptedHeadFreshnessLock") :test #'string=)) "S4")
    ((and (string= state "S4") (member trigger '("Fv07Pass" "VerifiedRehydrationClosure") :test #'string=)) "S5")
    ((and (string= state "S5") (member trigger '("Fv08Pass" "ReplayReconstruction") :test #'string=)) "S6")
    ((and (string= state "S5") (string= trigger "ReplayAdmissibleClosure")) "S8")
    ((and (string= state "S6") (member trigger '("Fv10AndFv11Pass" "FamilyReportAssembly") :test #'string=)) "S7")
    ((and (string= state "S7") (member trigger '("FamilyVerdictIssued" "EmitFamilyVerdict") :test #'string=)) "S8")
    ((and (string= state "SH") (member trigger '("HoldCaseWithNewFamilyClosureBundleAndAnchorUpdate" "ReadmissionReview") :test #'string=)) "SR")
    ((and (string= state "SR") (member trigger '("ReadmissionBundleChangedCarriedPayload" "ReadmissionBundleChangedAnchorDocumentRef" "ReadmissionBundleChangedSourceControlBundles") :test #'string=)) "S2")
    ((and (string= state "SR") (member trigger '("ReadmissionBundleChangedPolicySnapshotId" "ReadmissionBundleChangedRehydrationClosureRef") :test #'string=)) "S5")
    ((and (string= state "S8") (string= trigger "Handoff")) "S8")
    ((and (string= state "SX") (string= trigger "IncidentOnlyOutput")) "SX")
    (t state)))

(dolist (state *states*)
  (dolist (trigger *triggers*)
    (dolist (passed '(nil t))
      (format t "~a~%" (next-state state trigger passed)))))
