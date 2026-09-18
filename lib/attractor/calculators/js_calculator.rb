# frozen_string_literal: true

module Attractor
  class JsCalculator < BaseCalculator
    def initialize(file_prefix: "", ignores: "", minimum_churn_count: 3, start_ago: 365 * 5, verbose: false, files: nil)
      super(file_prefix: file_prefix, ignores: ignores, file_extension: "(js|jsx)", minimum_churn_count: minimum_churn_count, start_ago: start_ago, verbose: verbose, files: files)
      @type = "JavaScript"
    end

    def calculate
      super do |change|
        file_path = File.expand_path(change[:file_path])
        output = `node #{__dir__}/../../../dist/calculator.bundle.js #{file_path}`

        complexity, details, symbols = JSON.parse(output)

        [complexity, details, symbols]
      end
    end
  end
end
