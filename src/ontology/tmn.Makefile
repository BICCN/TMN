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

IMPORT_UNMERGE=$(COMPONENTSDIR)/import_unmerge.owl

#Removing axioms that cause multiple equiv class clashes for now
#See https://github.com/bio-ontology-research-group/unit-ontology/issues/47 & https://github.com/bio-ontology-research-group/unit-ontology/issues/46
#See https://github.com/BICCN/TMN/pull/107 for EFO related axiom removal

$(IMPORTDIR)/merged_import.owl: $(MIRRORDIR)/merged.owl $(IMPORTDIR)/merged_terms_combined.txt
	if [ $(IMP) = true ]; then $(ROBOT) merge -i $< \
		remove  --select "<http://www.informatics.jax.org/marker/MGI:*>" remove  --select "<http://purl.obolibrary.org/obo/OBA_*>" remove  --select "<http://purl.obolibrary.org/obo/ENVO_*>" remove  --select "<http://purl.obolibrary.org/obo/GOCHE_*>" remove  --select "<http://purl.obolibrary.org/obo/NCBITaxon_Union_*>" remove  --select "<http://www.genenames.org/cgi-bin/gene_symbol_report*>"  \
		unmerge -i $(IMPORT_UNMERGE) \
		extract -T $(IMPORTDIR)/merged_terms_combined.txt --force true --copy-ontology-annotations true --individuals exclude --method BOT \
		query --update ../sparql/inject-subset-declaration.ru --update ../sparql/postprocess-module.ru \
		annotate --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) --output $@.tmp.owl && mv $@.tmp.owl $@; fi

