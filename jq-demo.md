 --
 
# *jq* demo

## Creating our list of journal titles

*jq* makes it very easy to filter the complex output from the ORCID api into
a simple list of journal titles. This is done by a dot notation path.

```shell
    jq '.["orcid-profile"]["orcid-activities"]["orcid-works"]["orcid-work"][]["journal-title"].value' example.json
```

Initial output

```text
    null
    "Science & Technology Libraries"
    "Abstracts of Papers of the American Chemical Society"
    "Chemical Information for Chemists"
    null
    "Abstracts of Papers of the American Chemical Society"
    "Abstracts of Papers of the American Chemical Society"
    "Abstracts of Papers of the American Chemical Society"
    "Abstracts of Papers of the American Chemical Society"
    "Abstracts of Papers of the American Chemical Society"
    "Abstracts of Papers of the American Chemical Society"
    "Abstracts of Papers of the American Chemical Society"
    null
```

Piping the output through `grep -v null | sort -u ` cleans up the list easily

```shell
    jq '.["orcid-profile"]["orcid-activities"]["orcid-works"]["orcid-work"][]["journal-title"].value' example.json | grep -v "null" | sort -u
```

--
Final list to check

```text
    "Abstracts of Papers of the American Chemical Society"
    "Chemical Information for Chemists"
    "Science & Technology Libraries"
```
--

# More experimentation

After much more experimentation and looking up the *jq* [documentation](https://stedolan.github.io/jq) we came with this
expression to generate a tab delimited file with work type, journal title, id type and id

```
    jq '.["orcid-profile"]["orcid-activities"]["orcid-works"]["orcid-work"][]' example.json |\
      jq '{workType: .["work-type"], journalTitle: .["journal-title"].value, id: .["work-external-identifiers"]["work-external-identifier"][]["work-external-identifier-id"].value, idType: .["work-external-identifiers"]["work-external-identifier"][]["work-external-identifier-type"]}' |\
        jq -r '. | [.workType, .journalTitle, .idType, .id] | join("\t")' > example.tab
```

See [example.tab](example.tab)

```text
    JOURNAL_ARTICLE		DOI	10.5062/F42R3PMS
    JOURNAL_ARTICLE		EID	10.5062/F42R3PMS
    JOURNAL_ARTICLE		DOI	2-s2.0-84858766300
    JOURNAL_ARTICLE		EID	2-s2.0-84858766300
    JOURNAL_ARTICLE	Science & Technology Libraries	DOI	10.1080/0194262x.2015.1135304
    JOURNAL_ARTICLE	Abstracts of Papers of the American Chemical Society	ISSN	0065-7727
    OTHER	Chemical Information for Chemists	DOI	10.1039/9781782620655-00206
    OTHER	Chemical Information for Chemists	ISBN	10.1039/9781782620655-00206
    OTHER	Chemical Information for Chemists	DOI	978-1-84973-551-3
    OTHER	Chemical Information for Chemists	ISBN	978-1-84973-551-3
    JOURNAL_ARTICLE		DOI	10.5062/F42R3PMS
    JOURNAL_ARTICLE		EID	10.5062/F42R3PMS
    JOURNAL_ARTICLE		DOI	2-s2.0-84858766300
    JOURNAL_ARTICLE		EID	2-s2.0-84858766300
    JOURNAL_ARTICLE	Abstracts of Papers of the American Chemical Society	ISSN	0065-7727
    JOURNAL_ARTICLE	Abstracts of Papers of the American Chemical Society	ISSN	0065-7727
    JOURNAL_ARTICLE	Abstracts of Papers of the American Chemical Society	ISSN	0065-7727
    JOURNAL_ARTICLE	Abstracts of Papers of the American Chemical Society	ISSN	0065-7727
    JOURNAL_ARTICLE	Abstracts of Papers of the American Chemical Society	ISSN	0065-7727
    JOURNAL_ARTICLE	Abstracts of Papers of the American Chemical Society	ISSN	0065-7727
    JOURNAL_ARTICLE	Abstracts of Papers of the American Chemical Society	ISSN	0065-7727
    CONFERENCE_PAPER		EID	2-s2.0-2442514124
```

This is OK but some of this is easier in other tools (e.g. Open Refine).

--

