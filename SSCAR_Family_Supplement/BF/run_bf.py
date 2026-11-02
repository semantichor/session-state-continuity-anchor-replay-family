"""Run the Brainfuck rendering over every family projection tuple and probe."""
import os, shutil, subprocess, tempfile
from pathlib import Path
from gen_bf import BF, STATES, TRIGGERS, TRIGGER_CODES, VERDICTS, PROBES

ROOT = BF.parent

def main():
    setting = os.environ.get("GCC_CMD", "gcc")
    compiler = shutil.which(setting) if not Path(setting).is_absolute() else setting
    if not compiler: raise SystemExit(f"C compiler not found: {setting}")
    env = os.environ.copy(); env["PATH"] = str(Path(compiler).parent)+os.pathsep+env.get("PATH", "")
    with tempfile.TemporaryDirectory(prefix="sscar-bf-", dir=ROOT) as temporary:
        exe = Path(temporary)/"bf_interpreter.exe"
        subprocess.run([compiler,"-O2","-std=c99","-Wall","-Wextra",str(BF/"bf.c"),"-o",str(exe)],cwd=BF,env=env,check=True)
        output=[]; records=[]
        for si,state in enumerate(STATES):
            for ti,trigger in enumerate(TRIGGERS):
                for passed in (False,True):
                    record=f"n{chr(ord('A')+si)}{TRIGGER_CODES[ti]}{'p' if passed else 'f'}-"
                    got=subprocess.run([str(exe),str(BF/"baseline.bf")],input=record.encode("ascii"),stdout=subprocess.PIPE,stderr=subprocess.PIPE,env=env,check=True).stdout
                    output.append(got); records.append(record)
        result=b"".join(output); reference=(ROOT/"LISP"/"spec_792.txt").read_bytes()
        if result!=reference:
            expected=reference.splitlines()
            for index,(got,want) in enumerate(zip(output,expected)):
                if got.rstrip(b"\r\n")!=want: raise SystemExit(f"Brainfuck mismatch at {records[index]}: {got!r} != {want!r}")
            raise SystemExit(f"Brainfuck vector length mismatch: {len(result)} != {len(reference)}")
        (BF/"bf_792.txt").write_bytes(result)
        probes={**{f"s{i:X}---":state for i,state in enumerate(STATES)},**{f"v{i:X}---":value for i,value in enumerate(VERDICTS)},**{f"p{k}---":value for k,value in PROBES.items()}}
        probe_lines=[]
        for record,want in probes.items():
            got=subprocess.run([str(exe),str(BF/"baseline.bf")],input=record.encode("ascii"),stdout=subprocess.PIPE,stderr=subprocess.PIPE,env=env,check=True).stdout.decode("ascii").strip()
            if got!=want: raise SystemExit(f"Brainfuck probe {record}: {got!r} != {want!r}")
            probe_lines.append(f"{record}={got}")
        (BF/"surface_probes.txt").write_bytes(("\n".join(probe_lines)+"\n").encode("utf-8"))
        print(f"tuples={len(output)} byte_equal=True probes={len(probes)}")

if __name__ == "__main__": main()
