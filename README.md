# Techniques and Methods Ontology
This is the developers repository for a techniques and methods ontology to support work at AIBS and BICCN. The techniques and methods ontology is designed to help scientists communicate about their experiments and results by defining a set of terms for techniques, methods, modalities, assays, devices, tools, and the like. 

# Editing
The ontology is comprised of a few groups of terms. Generally speaking, there are three ways to edit or add to the ontology: 

1. external terms (from other ontologies): Use [OntoFox](http://ontofox.hegroup.org) for importing terms from other ontologies. Edit the corresponding [file name] file. 
2. template terms: Use [ROBOT](http://robot.obolibrary.org/template) to convert spreadsheets to OWL. Edit the relevant [file name] file:
  - [techniques] for techniques.
  - [modalities] for modalities.
  - [methods] for methods.
  - [assays] for assays. 
  - [devices] for devices.
  - [tools] for tools.
3. other terms: Edit [owlfile] in Protege.

# Files
- [`README.md`](README.md) the document you are currently reading. 
- [.owl] the latest release of the ontology.
- [Makefile] scripts for building the ontology.
- [views/] various specialized views of the ontology.
    - [.obo] the latest release of the ontology in .obo file format
    - [core.owl] the latest release of ontology core: ~100 key terms
- [src/]
    - [ontology/] source files for the ontology.
        - [.owl] the main OWL file
        - [core.txt] the list of core terms
        - [templates/] ROBOT template files for various branches of the ontology
        - [modules/] the results of the ROBOT templates
    - [sparql/] SPARQL queries for building and validating the ontology
    - [scripts/] utility scripts
    - [views/] configuration for views

# Building

The [Makefile] contains scripts for building the ontology. On macOS or Linux, you should just be able to run `make` or one of the specific tasks below.

[edit these]

# Development

We use git and GitHub to develop. There's a lot of good documentation on both:

- git [website](https://git-scm.com) with files and documentation
- GitHub [Help](https://help.github.com) and [Flow](https://guides.github.com/introduction/flow/)
- [git command-line overview](http://dont-be-afraid-to-commit.readthedocs.io/en/latest/git/commandlinegit.html)

## Making Changes

Changes should be made in manageable pieces, e.g. add one term or edit a few related terms. Most changes should correspond to a single issue on the tracker.

Start from a local copy of the `master` branch of the repository. Make sure your local copy is up-to-date. Make your changes on a new branch. Please use the [TMO Term ID Reservations] sheet to manage new IDs.

When you're ready, push your branch to the repository and make a Pull Request (PR) on the GitHub website. Your PR is a request to merge your branch back into `master`. Your PR will be tested, discussed, adjusted if necessary, then merged. Then the cycle can repeat for the next change that you or another developer will make.

These are the steps with their CLI commands. When using a GUI application the steps will be the same.

1. `git fetch` make sure your local copy is up-to-date
2. `git checkout master` start on the `master` branch
3. `git checkout -b your-branch-name` create a new branch named for the change you're making
4. make your changes
5. `make sort` sort and normalize tables, for cleaner diffs
6. `git status` and `git diff` inspect your changes
7. `git add --update src/` add all updated files in the `src/` directory to staging
8. `git commit --message "Description, issue #123"` commit staged changes with a message; it's good to include an issue number
9. `git push --set-upstream origin your-branch-name` push your commit to GitHub
10. open <link> in your browser and click the "Make Pull Request" button

Your Pull Request will be automatically tested. If there are problems, we will update your branch. When all tests have passed, your PR can be merged into `master`. Rinse and repeat!


## Clean Work

The easiest way to edit `src/ontology/template/` files is with Excel. Unfortunately Excel has some idiosyncratic rules for quoting cell values, and on macOS [uses old line endings](http://developmentality.wordpress.com/2010/12/06/excel-2008-for-macs-csv-bug/). Both these things make our diffs messy and confusing.

For clean diffs, we also like to keep out templates sorted by ID. The `make sort` command will fix line endings and sorting by running all the templates through a Python script.
