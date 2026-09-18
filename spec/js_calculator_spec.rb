require "spec_helper"

RSpec.describe Attractor::JsCalculator do
  let(:fixture_path) { "#{RSPEC_FIXTURES_PATH}/sample_js/app.js" }
  let(:churn_calc_instance) { instance_double(::Churn::ChurnCalculator) }

  before do
    allow(::Churn::ChurnCalculator).to receive(:new).and_return(churn_calc_instance)
    allow(Attractor::Cache).to receive(:read).and_return(nil)
    allow(Attractor::Cache).to receive(:write)
    allow(Attractor::Cache).to receive(:persist!)
  end

  describe "#calculate" do
    before do
      allow(churn_calc_instance).to receive(:report).and_return(churn: {changes: [{times_changed: 3, file_path: fixture_path}]})
    end

    it "returns method details with scores and locations" do
      calculator = described_class.new

      values = calculator.calculate

      expect(values.size).to eq(1)
      value = values.first
      expect(value.file_path).to eq(fixture_path)
      expect(value.complexity).to eq(7)

      details = value.details
      expect(details["topLevel"]).to eq({"score" => 2, "line" => 4, "end_line" => 9})
      expect(details["MyClass#method1"]).to eq({"score" => 2, "line" => 12, "end_line" => 17})
      expect(details["MyClass#method2"]).to eq({"score" => 2, "line" => 19, "end_line" => 23})
    end
  end

  describe "javascript calculator output" do
    it "includes module references from import statements" do
      calculator_path = File.expand_path("../src/javascript/calculator/index.js", __dir__)
      output = `node #{calculator_path} #{fixture_path}`
      _complexity, _details, symbols = JSON.parse(output)

      expect(symbols["references"]).to contain_exactly("react", "./helpers")
    end
  end
end
