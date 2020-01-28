require "attractor/javascript/version"

require "attractor"
require "attractor/registry_entry"
require "attractor/calculators/base_calculator"
require "attractor/calculators/js_calculator"
require "attractor/detectors/base_detector"
require "attractor/detectors/js_detector"

module Attractor
  module Javascript
    class Error < StandardError; end

    Attractor.register(Attractor::RegistryEntry.new(type: "js", detector_class: JsDetector, calculator_class: JsCalculator))
  end
end
