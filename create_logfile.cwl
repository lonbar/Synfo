cwlVersion: v1.2
class: CommandLineTool
baseCommand: [sadf, -dht, --, -prub]

stdout: $(inputs['date']).csv

inputs:
    date:
        type: string
        inputBinding:
            prefix: /var/log/sa/sa
            position: 0
            separate: false

outputs:
    log:
        type: File
        outputBinding:
            glob: $(inputs['date']).csv
