## Customize Makefile settings for TMN
## 
## If you need to customize your Makefile, make
## changes here rather than in the main Makefile

.PHONY: all_reports
all_reports: all_reports_onestep $(REPORT_FILES)

$(REPORTDIR)/validate_profile_owl2dl_%.txt: % | $(REPORTDIR)
	#$(ROBOT) validate-profile --profile DL -i $< -o $@
.PRECIOUS: $(REPORTDIR)/validate_profile_owl2dl_%.txt

.PHONY: validate_profile_%
validate_profile_%: $(REPORTDIR)/validate_profile_owl2dl_%.txt