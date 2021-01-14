# Requesting an AIO Term [draft]

First, check whether the term you would like occurs in an ontology already (use [OntoBee](http://www.ontobee.org), [BioPortal](https://bioportal.bioontology.org), or [OLS](https://www.ebi.ac.uk/ols/ontologies)). You should also check for synonyms of the term you would like. To request a new term, click [issues] on the upper left-hand side of the GitHub for the Techniques Ontology, and then send a new term request to the issue tracker. When submitting your request for a new term, please follow the guidelines at the end of this section.

Things to know about terms: OBO has its own policy for naming terms. Every OBO ontology has its own "ID space" (a string of letters signifying the ontology) and a "Local ID" (a string of digits). The combination of those two are the term's identifier -- this is the ID of an OBO term. When you add [http://purl.obolibrary.org/obo/] and an underscore between the ID space and the Local ID, you get the term's IRI.

Obviously using numeric IDs for terms makes the term ID opaque for the human reader. That is, there is nothing about the ID that tells you that it's the ID for some specific term. However, this has advantages when we must replace a term with another (better!) term. If (for example) the term 'assay' is to be replaced, then it is easy to replace 'assay'. In this case 'assay' would then get a new ID and the old term can retain its ID (to support legacy data). If, on the other hand, we used a meaningful word instead of numerals, then it would be difficult to make such changes. Because ontologies are susceptible to changes, we should adopt this convention.

An advantage to numerical (opaque) IDs is that they make versioning easier. If we have some sort of opacity we wish to dispel, it is somewhat easy to do this with tools (software to go from unique numerical ID to human-readable text). However, moving from a (possibly) ambiguous term to a unique ID is often much more difficult. 

PURLs are "persistent URLs" insofar as they are simply URLs with the expectation that it will always point to one resource. PURLs do not change even if a resource is moved to a new server. 

No More than One Name: IRIs allow us to assign as many names as we would like, but we need to ask how many names we would want. Names are most useful the entities we want to talk about have one name. If we are using different names for one entity, confusion proliferates. Coordinating names is a challenge and this challenge only becomes more difficult when the community of users is large or when the knowledge of the domain is changing rapidly. Ontology is part of the solution to the problem of coordinating names. 

Speaking of names, it is good practice to reuse ontology terms when possible. IRIs provide us with all of the globally unique names that we need. Ontologies then give us systems of standardized names (and a bunch of other things). "Using" an OBO reference ontology term simply means using its IRI in your data. Every term needs to have one (and only one) IRI. 

## Existing Terms

If you find a term in OntoBee or BioPortal that you would like in this ontology, simply ask for an import of that term in the next version release of the ontology. If you find a term that is close but may need some additions or changes, submit a new ticket to the issue tracker and include:

1. the name of the term in the title of the ticket
2. the IRI that identifies the term [http://purl.obolibrary.org/obo/BFO_0000001]
3. a description of the changes you would like and the reasons for the change.

## New Terms

If you cannot find the term you would like using the above search parameters, you should request a new term. Our developers would like the following information when possible:

1. editor preferred term -- a unique, unambiguous label for the term in American English. This is an unambiguous label that uniquely identifies the term within the OBO Foundry. Sometimes you might see [rdfs:label] for this instead. There must be one and only one editor preferred term, and it must be in American English. It should not contain any acronyms or jargon words, and it should make sense when read outside the context of a scientific investigation. This might make the terms become rather cumbersome and unsightly, but it is more important to make sure that they are clear. 
2. alternative terms -- common synonyms or translations. There can be many alternative term annotations for a given term. They can include acronyms and jargon -- if the editor preferred term spells out an acronym then it is a good idea to put the abbreviated form in an alternative term annotation. They can be in any language, but make sure to specify which language if it is not American English. Alternative term annotations do not have to be unique across OBO.
3. textual definition -- proposed. The textual definition is the most important annotation because it expresses the meaning of the term. Definitions should have Aristotelian form: "An A is a B that C" where A is the new term, B is the parent term, and C specifies how A is a special kind of B. Every term needs one and only one textual definition, in American English, and definitions must be unique across the OBO Foundry. 
4. definition source for the textual definition. Every textual definition should have a definition source. If you created the definition, then you are the source. If the definition was adapted from Wikipedia or some other website, then this annotation should contain the permanent URL. If it was adapted from a paper, use its DOI or PubMed URL.
5. logical definition (or simply the parent term). The logical definition of a term is almost as important as the textual definition. The logical definition expresses the meaning of the term in a machine-readable way using the Web Ontology Language (OWL) 2.0. Most OBO terms are OWL Classes (i.e., general nouns) and they require a single parent class. Many of them have more complex logical definitions. If you are not comfortable specifying a logical definition, that is fine -- the AIO developers will help create one based on the textual definition you provide. 
6. example of usage. One or more example of usage annotations can clarify the meaning of a term. While the textual definition must be general enough to cover all cases, the examples provide specific cases that show the term in use. Examples of usage can be common cases that demonstrate the prototypical usage, or uncommon edge cases that delimit the scope of the term. While not strictly required, every new term should have one or more examples of usage.
7. term editor -- your name and that of any collaborators (as it will appear in the ontology). We want to give you credit for your work. We will add one or more term editor annotations with your name, and the names of others who have collaborated on creating the term. 

## Term Relationships

### Parents
Every term in the ontology must have at least one (is_a) parent and can have as many relationships to other terms as necessary.

### Equivalence Axioms
Equivalence axioms represent a special set of relationships that define a term with both necessary and sufficient conditions. For example the equivalence axiom for GO:0055085 transmembrane transport is transport and ('results in transport across' some membrane). This means that if a process is transmembrane transport, it result in transport across a membrane (necessary condition). It also means that any process that transports across a membrane is_a transmembrane transport (sufficient). Whenever possible, equivalence axioms should be created for every term.

### Disjoint Axioms
Terms are made disjoint when they have no children in common. Disjoint relationships can be very useful in that they can be used to identify inconsistencies in the ontology. For example, GO:0003690 double-stranded DNA binding is disjoint with GO:0003697 single-stranded DNA binding.

### Reasoning
Reasoning is critical to the keeping the AIO maintainable. Any term in AIO may have many parents. In an ontology that is large and complex, maintaining classifications of this type by hand in is very error-prone as placing a class correctly in the hierarchy requires editors to know what parents are available. It is much more sustainable to record just one asserted classification along with a set of conditions for class membership and then to rely on automated classification for the rest.
