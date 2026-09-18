const fs = require("fs");
const escomplex = require("typhonjs-escomplex");

const file = process.argv[2];

try {
  const report = escomplex.analyzeModule(fs.readFileSync(file).toString());

  const details = {};

  const addMethod = (m, className = null) => {
    const name = className ? `${className}#${m.name}` : m.name;
    details[name] = {
      score: m.cyclomatic,
      line: m.lineStart,
      end_line: m.lineEnd
    };
  };

  report.methods.forEach(m => addMethod(m));

  (report.classes || []).forEach(klass => {
    (klass.methods || []).forEach(m => addMethod(m, klass.name));
  });

  const symbols = {
    references: (report.dependencies || []).map(d => d.path)
  };

  console.log(JSON.stringify([report.aggregate.cyclomatic, details, symbols]));
} catch (e) {
  console.log(JSON.stringify([0, {}, {references: []}]));
}
