
# Command Line for Librarians

## MMWCon 2016

+ Presenter Heather Wilson
    + Acquisitions and Electronic Resources Librarian
    + California Institute of Technology
+ Presenter R. S. Doiel
    + Digital Services Programmer, Caltech Library
    + California Institute of Technology

About: [presentation](index.html)

--

# Overview

--

# the web is more than a web browser

+ the web is webpages
+ the web interlinked data
+ the web web is available on the command line

--

# What does the command line offer?

+ allows you to explore content in other formats
+ mix and match data and sources
+ it allows you to automate processes

--

# What is Bash

+ Bash is a Unix shell
+ It provides a command line interface to programs
+ It can be used to write small programs known as "scripts"
+ It is the default shell for many Linux systems as well as Mac OS X
+ It also is available for Windows 10 Anniversary Edition

--

# Why do I care?

+ Bash lets you automate repetative tasks
+ It helps you 

--

# it's all about the metadata

+ Librarians are interested in Metadata
+ Often it is incomplete
+ but often combining it one source with another lets us get a big picture

--

# Basics of command line

+ keyboard navigation
+ autocomplete is your friend
+ command history and your road to scripts

--

# Old Unix tools

+ *curl* is the jackknife to access
+ *cat* and *more*
+ *cut*, *sed* and *grep*
+ *xpath* to filter XML

--

# Some New tools

+ [jq](https://github.com/stedolan/jq) - 
    + *jq* to filter for JSON
+ mkpage - easily assemble webpages from asimple templates
+ md2slides - how this presentation was render
+ ws - a simple web server for development

--

# Scripting is autoamation

+ putting it together from experiments and history
+ simple scripts (list of commands)
+ complicated scripts (decisions and functions)

--

# Case Study (data source, open web API)

Applying the techniques of the open web

## OCLC Public Web API retrieving Call Numbers

+ Problem
    + Processing a CSV file to get additional call number data from OCLC web API
    + Data comes back as XML
+ Lessons learned
    + leverage environment variables for 
    + authorization key handling

--

# Case Study (api keys, mostly open web API)

Get a list and generate a webpage

## ORCID

+ Problem
    + Generate a publication list for colleague homepage


--
# Case Study (data assembly)

## GOKb API, Open Access Journals

+ Problem
    + generate reports, list of links, or indexes for searching 



--

# Data Cleanup 

+ Open refine (data cleanup)
    + de-dup
    + cleaning up stats
    + mass corrections
    + bulk spreadsheet/CSV files


