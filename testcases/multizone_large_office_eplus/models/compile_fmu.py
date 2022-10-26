from parsing import parser

def compile_fmu():
    '''Compile the fmu.

    Returns
    -------
    fmupath : str
        Path to compiled fmu.

    '''

    # DEFINE MODEL
    mopath = 'EPlusLargeOffice/package.mo'
    modelpath = 'EPlusLargeOffice.Testcases.LargeOffice'

    # COMPILE FMU
    fmupath = parser.export_fmu(modelpath, [mopath])

    return fmupath

if __name__ == "__main__":
    fmupath = compile_fmu()
