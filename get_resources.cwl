cwlVersion: v1.2
class: Workflow
id: Plot_statistics
label: Create plots for system resource usage
doc: |
    This workflow takes a padded number in the
    interval [01,31] as its argument, which
    corresponds to a date. It then attempts to
    access the nodes' sar logfile for this date,
    and if successful uses it to create plots of
    the use of system resources. The resources
    taken into consideration are percentages of
    memory and RAM, as well as disk read/write
    speed. Multiple dates can be given, in which
    case the workflow will repeat the process for
    each date.

requirements:
    MultipleInputFeatureRequirement: {}
    ScatterFeatureRequirement: {}

inputs:
    date:
        type: string[]
        doc: |
            An array of padded string between 1 and 31 inclusive.
            That is, valid inputs are e.g. 01, 02, 06, 12, 31.

outputs:
    logs:
        type: File[]
        doc: The sar log file.
        outputSource: check_date/log
    images:
        type: File[]
        doc: The  
        linkMerge: merge_flattened
        outputSource: [plot_percentages/images,
                       plot_io/images
                      ]

steps:
    check_date:
        in:
            date: date
        scatter: date
        out: [log]
        label: Create logfile
        doc: |
            Attempts to access the sar logfile
            for the date number given.
        run: ./create_logfile.cwl
    plot_percentages:
        in:
            log: check_date/log
        scatter: log
        out: [images]
        label: Plot statistics
        doc: |
            Generates a plot of the percentage
            of memory and CPU usage.
        run: ./plot_percentages.cwl
    plot_io:
        in:
            log: check_date/log
        scatter: log
        out: [images]
        label: Plot statistics
        doc: |
            Generates a plot of the read/write
            speeds of the node.
        run: ./plot_io.cwl
