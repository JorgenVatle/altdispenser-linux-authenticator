let exec = require("child_process").exec;

let sudo = require("electron-sudo").default;

const path = require("path");
let scriptsPath = path.join(__dirname, "scripts");

let options = {
    cwd: scriptsPath,
    env: {
        'JAVA_HOME': '/usr/lib/jvm/default/jre'
    }
}

module.exports = {
    executeActivation: function(out) {
        out("Executing...");
        exec('bash ' + path.join(scriptsPath, "activate.sh"), options, (err, stdout, stderr) => {
            out(stdout);
        });
    },

    executeDeactivation: function(out) {
        out("Executing...");
        exec('bash ' + path.join(scriptsPath, "deactivate.sh"), options, (err, stdout, stderr) => {
            out(stdout);
        });
    }
}