cwlVersion: v1.2
class: CommandLineTool

baseCommand: [python3, plot_stuff.py]

inputs:
    log:
        type: File
        inputBinding:
            position: 0

outputs:
    images:
        type: File
        outputBinding:
            glob: '*.jpg'

requirements:
    InitialWorkDirRequirement:
        listing:
            - entryname: plot_stuff.py
              entry: |
                import pandas
                import sys

                input = sys.argv[1]
                
                df = pandas.read_csv(input, sep=';')
                df['timestamp'] = pandas.to_datetime(df['timestamp'],
                                                     format='%Y-%m-%d %H:%M:%S')
                date = df['timestamp'][0].date()
                title = df['# hostname'][0]
                df['timestamp'] = df['timestamp'].dt.strftime('%H:%M:%S')
                plot = df.plot(x='timestamp',
                               y=['%user',
                                  '%idle[...]',
                                  '%memused'],
                               xlabel="Time",
                               ylabel="Percentage",
                               title=title,
                               label=['user CPU %',
                                      'idle CPU %',
                                      'memory %'],
                               rot=25).get_figure()
                
                plot.savefig(f'{date}_perc.jpg')
