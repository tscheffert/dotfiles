# README Doc Styleguide

## From writethedocs

```
$project
========

$project will solve your problem of where to start with documentation,
by providing a basic explanation of how to do it easily.

Look how easy it is to use:

    import project
    # Get your stuff done
    project.do_stuff()

Features
--------

- Be awesome
- Make things faster

Installation
------------

Install $project by running:

    install project

Contribute
----------

- Issue Tracker: github.com/$project/$project/issues
- Source Code: github.com/$project/$project

Support
-------

If you are having issues, please let us know.
We have a mailing list located at: project@google-groups.com
```

## Template:

# Repo Title

Notes:

Header should match the name of the repo

## Table of contents

<Content>

Notes:

The optional TOC can outline the remainder of the README document if it gets exceptionally long.

Use Anchor Links: <https://docs.microsoft.com/en-us/azure/devops/project/wiki/markdown-guidance?view=azure-devops#anchor-links>

## Introduction

### Description

Example:

Foobar is a Python library for dealing with word pluralization.

Notes:

TLDR: Sell people on your project

* What is it, what does it do / Abstract
* Project status: working/prototype

Let people know what your project can do specifically. Provide context and add a link to any reference visitors might be unfamiliar with. A list of Features or a Background subsection can also be added here. If there are alternatives to your project, this is a good place to list differentiating factors.

The introduction (required) shall consist of a brief paragraph or two that summarizes the purpose and function of this project. This introduction may be the same as the first paragraph on the project page.

### Features

Example:

<content>

Notes:

Use this section to list "back of the box features". A bullet point list of all the interesting things your repo can do.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

Notes on section:

For people who want to make changes to your project, it's helpful to have some documentation on how to get started.

Use examples liberally, and show the expected output if you can. It's helpful to have inline the smallest example of usage that you can demonstrate, while providing links to more sophisticated examples if they are too long to reasonably include in the README.

Perhaps there is a script that they should run or some environment variables that they need to set.
Make these steps explicit.

These instructions could also be useful to your future self.

### Prerequisites

What things you need to install the software and how to install them

```bash
asdf install ruby
```

Notes:

List _all_ requirements, both direct and indirect. Be specific about versions.

The idea is to inform the users about what is required,
so that everything they need can be procured and included in advance of attempting to use the project.
If there are no requirements, write "No special requirements".

### Installation

Example:

Use the package manager [pip](https://pip.pypa.io/en/stable/) to install foobar.

```bash
pip install foobar
```

Notes:

The installation section shall make it clear how to install the repo. However, if the steps to install the repo follow the standard instructions as some other process, then don't reinvent the wheel and simply link that that established process.

Within a particular ecosystem, there may be a common way of installing things, such as using Yarn, NuGet, or Homebrew.
However, consider the possibility that whoever is reading your README is a novice and would like more guidance.
Listing specific steps helps remove ambiguity and gets people to using your project as quickly as possible.
If it only runs in a specific context like a particular programming language version or operating system or has dependencies that have to be installed manually, also add a Requirements subsection.

### Configuration (Optional)

Example:

<content>

Notes:

Use this section to list special notes about the configuration of this repo.
List necessary environment variables, API keys, secrets files, whatever is necessary to get it working working.


### Usage

Example:

```python
import foobar

foobar.pluralize('word') # returns 'words'
foobar.pluralize('goose') # returns 'geese'
foobar.singularize('phenomena') # returns 'phenomenon'
```

For more examples, please refer to the [Documentation](example.com)

## Development and Contributing

This section should have most of the details necessary to get you started on making changes to this repo!

Notes on section:

These steps help to ensure high code quality and reduce the likelihood that the changes inadvertently break something.
Having instructions for running tests is especially helpful if it requires external setup, such as starting a Selenium server for testing in a browser.

### Pull Requests

Example:

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests and run the linter as appropriate.

Notes:

State if you are open to contributions and what your requirements are for accepting them.

### Testing

### Linting

### Deployment

## Troubleshooting & FAQ (optional)

These sections are optional. If present, they should address questions that are asked frequently in the issue queue (this will save you time in the future). Outline common problems that people encounter along with solutions (links are okay if the steps are long, but it is often helpful to provide a summary since links sometimes go stale).


## Changelog

This project follows the [Keep A Changelog](https://keepachangelog.com/en/1.0.0/) format and has a changelog.

## Roadmap

<Content>

Notes:

If you have ideas for releases in the future, it is a good idea to list them in the README.

## Built With

Example:

* [Dropwizard](http://www.dropwizard.io/1.0.2/docs/) - The web framework used
* [Maven](https://maven.apache.org/) - Dependency Management
* [ROME](https://rometools.github.io/rome/) - Used to generate RSS Feeds

Notes:

List all the things that were used to build the project, and any relevant links or documentation


## Support

<Content>

Notes:

Tell people where they can go to for help. It can be any combination of an issue tracker, a chat room, an email address, etc.
