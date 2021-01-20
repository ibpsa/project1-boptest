from parsing import parser

def compile_fmu():
    '''Compile the fmu.

    Returns
    -------
    fmupath : str
        Path to compiled fmu.

    '''

    # DEFINE MODEL
    mopath = 'MultiZoneOfficeSimpleAir/package.mo'
    modelpath = 'MultiZoneOfficeSimpleAir.TestCases.ASHRAE2006'

    # COMPILE FMU
    fmupath = parser.export_fmu(modelpath, [mopath])

    return fmupath

if __name__ == "__main__":
    fmupath = compile_fmu()
