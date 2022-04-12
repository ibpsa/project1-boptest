from parsing import parser

def compile_fmu():
    '''Compile the fmu.

    Returns
    -------
    fmupath : str
        Path to compiled fmu.

    '''

    # DEFINE MODEL
    mopath = 'BESTESTAir/package.mo'
    modelpath = 'BESTESTAir.TestCases.TestCase_Ideal'
    testcase_name = 'bestest_air'

    # COMPILE FMU
    fmupath = parser.export_fmu(modelpath, [mopath], testcase_name)

    return fmupath

if __name__ == "__main__":
    fmupath = compile_fmu()
