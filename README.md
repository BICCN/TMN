[![Build Status](https://travis-ci.org/BICCN/TMN.svg?branch=master)](https://travis-ci.org/BICCN/TMN)
[![DOI](https://zenodo.org/badge/13996/BICCN/TMN.svg)](https://zenodo.org/badge/latestdoi/13996/BICCN/TMN)

# Techniques and Methods for Neuroscience Ontology
This is the developers repository for a techniques and methods ontology to support work at AIBS and BICCN. The techniques and methods ontology is designed to help scientists communicate about their experiments and results by defining a set of terms for techniques, methods, modalities, assays, devices, tools, and the like.
## Versions

[v2022-06-07](releases/tag/v2022-06-07)

[v2022-04-06](releases/tag/v2022-04-06)

[v2021-11-10](releases/tag/v2021-11-10)

[v2021-09-02](releases/tag/v2021-09-02)

[v0.1](releases/tag/v0.1)
### Stable release versions

The latest version of the ontology can be found [here](TMN.owl)

### Browsing

The best way to browse TMN is to use Protege and open [the current release](TMN.owl) directly.

### Editors' version

Editors of this ontology should use the edit version, [src/ontology/TMN-edit.owl](src/ontology/TMN-edit.owl)

## Editing
Following best practices for ontology development, we attempt to reuse as many terms as we are able and attempt a rather modular approach to development. Although there are many ways to add to or edit the ontology, we try to stick to three main methods: 

1. When adding external terms (from other ontologies): Use [ODK import](src/ontology/imports/) functionality for importing terms. Simply create a branch, add the terms you would like to the .txt file of the source ontology of the term you wish to add, and make a pull request. If you are not comfortable with this process, simply provide a term request through our [issue tracker](http://github.com/BICCN/TMN/issues). 
2. When adding new terms: Edit [owlfile](src/ontology/TMN-edit.owl) in Protege.

# Files
- [`README.md`](README.md) the document you are currently reading. 
- [.owl](TMN.owl) the latest release of the ontology.
- [Makefile](src/ontology/Makefile) scripts for building the ontology.
- [.obo](TMN.obo) the latest release of the ontology in .obo file format
- [base.owl](TMN-base.owl) the latest release of ontology base: key terms
- [src/](src)
    - [ontology/](src/ontology) source files for the ontology.
        - [.owl](src/ontology/TMN-edit.owl) the main OWL file
        - [idranges/](src/ontology/TMN-idranges.owl) the list of id ranges
        - [reports/](src/ontology/reports) various reports from the latest build
    - [sparql/](src/sparql) SPARQL queries for building and validating the ontology
    - [scripts/](src/scripts) utility scripts
    - [patterns/](src/patterns) configuration for patterns

# Building

The [Makefile](src/ontology/Makefile) contains scripts for building the ontology. On macOS or Linux, you should just be able to run `make`.

# Development

We use git and GitHub to develop. There's a lot of good documentation on both:

- git [website](https://git-scm.com) with files and documentation
- GitHub [Help](https://help.github.com) and [Flow](https://guides.github.com/introduction/flow/)
- [git command-line overview](http://dont-be-afraid-to-commit.readthedocs.io/en/latest/git/commandlinegit.html)

## Making Changes

Changes should be made in manageable pieces, e.g. add one term or edit a few related terms. Most changes should correspond to a single issue on the tracker.

Start from a local copy of the `main` branch of the repository. Make sure your local copy is up-to-date. Make your changes on a new branch. Please use the [TMN-idranges file](src/ontology/TMN-idranges.owl) to manage new IDs.

When you're ready, push your branch to the repository and make a Pull Request (PR) on the GitHub website. Your PR is a request to merge your branch back into `main`. Your PR will be tested, discussed, adjusted if necessary, then merged. Then the cycle can repeat for the next change that you or another developer will make.

These are the steps with their CLI commands. When using a GUI application the steps will be the same.

1. `git fetch` make sure your local copy is up-to-date
2. `git checkout main` start on the `main` branch
3. `git checkout -b your-branch-name` create a new branch named for the change you're making
4. make your changes
5. `git status` and `git diff` inspect your changes
7. `git add --update src/` add all updated files in the `src/` directory to staging
8. `git commit --message "Description, issue #123"` commit staged changes with a message; it's good to include an issue number
9. `git push --set-upstream origin your-branch-name` push your commit to GitHub
10. open <link> in your browser and click the "Make Pull Request" button

Your Pull Request will be automatically tested. If there are problems, we will update your branch. When all tests have passed, your PR can be merged into `main`.

## Contact

Please use this GitHub repository's [Issue tracker](http://github.com/BICCN/TMN/issues) to request new terms/classes or report errors or specific concerns related to the ontology.

## Acknowledgements

This ontology repository was created using the [ontology starter kit](https://github.com/INCATools/ontology-starter-kit)
