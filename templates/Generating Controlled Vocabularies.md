## Generating Controlled Vocabularies from Ontologies

This document is intended to describe how to use controlled terminological resources (sometimes resulting in a controlled vocabulary) and how to generate such resources from more semantically rich ontologies. This document is not intended as a comprehensive or definitive guide for all such efforts, but only a descriptive document of the particular method used for this project. 

A `controlled vocabulary` is a semi-closed set of terms that are used for a particular purpose. Controlled vocabularies are semi-closed because they can gain or lose members, but only through a prescribed process. If there is no prescribed process for adding or removing members of a set comprising a controlled vocabulary, then the set becomes uncontrolled and is simply a list of terms. Additionally, controlled vocabularies (in virtue of their being controlled) must be managed by a source. In this case, we use the prescribed process as implemented in this repository for the mechanism that controls the vocabulary. 

Controlled vocabularies minimally contain terms acceptable for a specific usage (as defined by the controlling mechanism or agents). They may also contain other information about the terms that occur in the vocabulary (e.g., definitions, synonyms, examples of usage, notes, metadata) but need not contain anything other than a simple list of terms. This stands in contrast to an ontology, which contains a set of classes and relations (and sometimes individuals) meant to be representative of a portion of reality. Of course, those classes and relations (and individuals) have names or labels, so it should be (in principle) possible to generate a controlled vocabulary by extracting the names and labels of classes and relations of an ontology and calling that a “controlled vocabulary.” One of the benefits of this approach is that it is also possible, in principle, to extract other information about those classes/relations/individuals in an ontology and use that information in a controlled vocabulary as well. Since most good ontologies provide definitions of classes/relations, it should be possible to add definitions to terms in a controlled vocabulary by extracting both the label and the definition for every class/relation in an ontology (or subset thereof) and converting that into a controlled vocabulary. 

There is no standard format for a controlled vocabulary, but there are standards for ontologies. This makes the move from ontology to controlled vocabulary possible without much extra work (provided the ontology developer has followed the norms and rules of ontology development). The inverse move (generating an ontology from a controlled vocabulary) is much more difficult, if it is possible at all. 

There is (most likely) more information associated with a class in an ontology than one would presumably need for a term in a controlled vocabulary as well. For this reason, it is advised that anyone seeking to generate a controlled vocabulary from an ontology should carefully consider what information they would like to extract from the ontology and what information they would like to ignore. For example, many (most, if not all) classes in an ontology will be annotated with formal axioms that allow automated reasoning over the classes/individuals in an ontology. Typically, these axioms are of no use to a user of a controlled vocabulary. So, it is generally advised that one ought not include these axioms in a controlled vocabulary even though they are very important in the ontology. Minimally, it is recommended that a controlled vocabulary contain the label (term), definition, and any relevant synonyms. These are the most helpful informational resources for the user. 

## Specifics of Implementation in this Instance

### Filter

First, we use the filter command to create a new ontology from the source ontology. The command works by copying only selected axioms in the ontology. In other words, the command strips all axioms (except those you specify to include) from the source ontology and creates a new ontology absent those axioms. If you don’t specify any axioms to include, you will receive an empty ontology. 

`filter` works by doing the following:

1.	Specifies an initial target set of objects to filter. 

The `--term` and `--term-file` options allow you to specify the initial target set. You can specify zero or more `--term` options (one term each), and zero or more `--term-file` options (one term per line). You can specify terms by IRI or CURIE. If you do not specify any terms, then the target set consists of all the objects in the ontology. 

If you wish to exclude a term or set of terms, you should use `--exclude-term <term>` or `--exclude-terms <term-file>`. Doing so will mean that these terms will NOT be included in the output. 

If you would like to include a term or set of terms, you should use `--include-term <term>` or `--exclude-terms <term-file>`. Doing so will mean that these terms will ALWAYS be included in the output. 

2.	Uses selectors to broaden or narrow the target set of objects.

The `--select` option lets you specify “selectors” that broaden or narrow the target set of objects. Some selectors such as `classes` take the target set and return a subset (i.e. all the classes in the target set). Other selectors such as `parents` return a new target set of related objects. The `parents` selector gets the parents of each object in the target set. Note that the `parents` set does not include the original target set, just the parents. Use the `self` selector to return the same target set. You can use multiple selectors together to get their union, so `--select "self parents"` will return the target set (`self`) and all the parents. You can use `--select` multiple times to modify the target set in several stages, so `--select parents --select children` will get the parents and then all their children, effectively returning the target set objects and all their siblings.

3.	Specifies the types of axioms to consider.

The `--axioms` option lets you specify which axiom types to consider. By default, all axioms are considered, but this can be restricted to annotation axioms, logical axioms, more specific subtypes, or any combination.

4.	Checks each axiom of the specified type against the target set of objects. 

The final step is to take each axiom of the specified types, and compare it to the target set. The `--signature` option works the same as `remove`, but `--trim` differs. When using `filter --trim true` (the default), if all objects for the axiom are in the target set then that axiom is copied to the new ontology. When using `filter --trim false`, if any object for the axiom are in the target set, then that axiom is copied.

#### Example

Here is an example:
ax1: A subClassOf B
ax2: A subClassOf R some C
ax3: D subClassOf E
`filter --term A --term R --term C --select "self parents" --axioms all --signature true --trim true` works like this: 
1.	The initial target set includes all the specified `--terms: {A, R, C}`
2.	For `self` we get just the initial target set `{A, R, C}`; for `parents` we get `{B, R some C}`; so the new target set is the union `{A, B, R, C, R some C}`
3.	`--axioms all` means that we consider all axioms
4.	For each axiom we compare the objects for the axiom to the target set. With `--signature true` we only consider the named objects, i.e. objects that have IRIs, not anonymous objects such as `R some C`. With `--trim true` we are checking that all objects for the axiom is in the target set.
o	the objects for `ax1` are `{A, B}`, and all of these are in the target set, so `ax1` is matched and copied
o	the objects for `ax2` are `{A, R, C}` (with R some C excluded), and all of these are in the target set, so `ax2` is matched and copied
o	the objects for `ax3` are `{D, E}`, and none of these are in the target set, so `ax3` is not matched and is not copied

The `filter` operation maintains structural integrity by default: lineage is maintained, and gaps will be filled where classes have been removed. If you wish to not preserve the hierarchy, include `--preserve-structure false`.

### Annotations

The `filter` command also includes a `--select “annotations”` selector. If you use this selector, all annotations on filtered terms will be copied, irrespective of whether the properties are in the set of terms. 

The following command will only return `OBI:000000070` with a label annotation:

[robot filter --input obi.owl --term OBI:0000070 --term rdfs:label]

If you want `OBI:0000070` with all annotations, then:

[robot filter --input obi.owl --term OBI:0000070 --select annotations]

## Examples

Copy a class (‘organ’) and all its descendants, with all annotations:

robot filter --input uberon_module.owl \
  --term UBERON:0000062 \
  --select "annotations self descendants" \
  --signature true \
  --output results/filter_class.owl

Copy all of OBI except descendants of ‘organ’ (using remove on ‘organ’ is preferred):

robot filter --input uberon_module.owl \
  --term UBERON:0000062 \
  --select annotations \
  --select descendants \
  --select complement \
  --signature true \
  --output results/remove_assay.owl

Copy a subset of classes based on an annotation property (maintains hierarchy):

robot filter --input uberon_module.owl \
  --prefix "core: http://purl.obolibrary.org/obo/uberon/core#" \
  --select "oboInOwl:inSubset=core:uberon_slim" \
  --select annotations \
  --signature true \
  --output results/uberon_slim.owl

Copy a class, all axioms that a class appears in and annotations on all the classes (only UBERON:0000062 here) in the filter set:

robot filter --input uberon_module.owl \
  --term UBERON:0000062 \
  --select annotations \
  --trim false \
  --signature true \
  --output results/uberon_annotated.owl

Create a “base” subset that only includes internal axioms (alternatively, use remove --axioms external):

robot filter --input template.owl \
  --base-iri http://example.com/ \
  --select "annotations" \
  --axioms internal \
  --include-term IAO:0000117 \
  --include-term IAO:0000119 \
  --output results/template-base-filter.owl

### Export

We can export details about an ontology entities as a table. The `export` command expects some input ontology (`--input`), a set of column headers (`--header`), and a file to write to (`--export`). 

robot export --input assays.owl \
  --header "LABEL|ALTERNATIVE TERMS|DEFINITION" \
  --export assays.csv

The export command is able to export an ontology in: tsv, csv, html, html-list, json, xlsx.

#### Columns

The `--header` option is a list of keywords or properties used in the ontology. The columns in the `--header` argument will exactly match the first line of the export file (i.e., the column headers). 

The following are supported:
  `IRI`: creates an “IRI” column based on the full unique identifier
  `ID`: creates an “ID” column based on the short form of the unique identifier (CURIE) - please note that all IRIs must have defined prefixes, or the full IRI will be returned.
  `LABEL`: creates a “Label” column based on rdfs:label (rdfs:label can also be used in place of this column)
  `SYNONYMS`: creates a “SYNONYMS” column based on all synonyms (oboInOwl exact, broad, narrow, related, or IAO alternative term)
  `SubClass Of`: creates a “SubClass Of” column based on rdfs:subClassOf
  `SubClasses`: creates a “SubClasses” column based on direct children of a class
  `Equivalent Class`: creates an “Equivalent Classes” column based on owl:equivalentClass
  `SubProperty Of`: creates a “SubProperty Of” column based on rdfs:subPropertyOf
  `Equivalent Property`: creates an “Equivalent Properties” column based on owl:equivalentProperty
  `Disjoint With`: creates a “Disjoint With” column based on owl:disjointWith
  `Type : creates an “Instance Of” column based on rdf:type for named individuals or the OWL EntityType for all others (e.g., Class)

The first header in the `--header` list is used to sort the rows of the export. You can change the column that is sorted on by including `--sort <header>`. This can eitehr be one header, or a list of headers that will be sorted in order.

#### Including and Excluding Entities

By default, the export includes details on the classes and individuals in an ontology. Properties are excluded. You can configure which types of entities you wish to include with the `--include <entity types>` option. The `<entity types>` argument is a space-, comma-, or tab-separated list of one or more of the following entity types. 

  `classes`
  `individuals`
  `properties`

For example, to return the details of individuals only:

robot --prefix "example: http://example.com/" \
  export --input template.owl \
  --header "ID|LABEL|Type" \
  --include "individuals" \
  --export results/individuals.csv

To return details of classes and properties:

robot export --input nucleus_part_of.owl \
  --header "ID|LABEL|Type|SubClass Of|SubProperty Of" \
  --include "classes properties" \
  --export results/classes-properties.csv

The --include option does not need to be specified if you are getting details on individuals and classes. If you do specify an --include, it cannot be an empty string, as no entities will be included in the export.

#### Rendering Cell Values

Entities used in cell values are rendered by one of four different strategies:

`NAME` - render the entity by label (if label does not exist, entity is rendered by CURIE)
`ID` - render the entity by short form ID/CURIE
`IRI` - render the entity by full IRI
`LABEL` - render the entity by label ONLY (if label does not exist, entity is rendered as an empty string)

By default, values are rendered with the NAME strategy. To update the strategy globally, you can use the --entity-format option and provide one of the above values:

robot export --input nucleus_part_of.owl \
  --header "ID|SubClass Of" \
  --entity-format ID \
  --entity-select NAMED \
  --export results/nucleus-ids.csv
  
In the above example, all the “subclass of” values will be rendered by their short form ID.

You can also specify different rendering strategies for different columns by including the strategy name in a square-bracket-enclosed tag after the column name:

robot export --input nucleus_part_of.owl \
  --header "rdfs:label|SubClass Of [ID]|SubClass Of [IRI]" \
  --entity-select NAMED \
  --export results/nucleus-iris.csv
These tags should not be used with the following default columns: LABEL, ID, or IRI as they will not change the rendered values.

These tags can be used for object and annotation property columns as well. When using these tags with annotation properties, the value in the cell will only change if the annotation value is an IRI. For literals, the annotation value will always be rendered the same, no matter what the tag is.
