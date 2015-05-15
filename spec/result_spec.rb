require 'spec_helper'

shared_examples_for 'a success' do
  let(:result) { described_class }
  it 'should be a success' do
    expect(result.success?).to eq true
  end

  it 'should not be a failure' do
    expect(result.failure?).to eq false
  end
end

shared_examples_for 'a failure' do
  let(:result) { described_class }
  it 'should be a success' do
    expect(result.success?).to eq false
  end

  it 'should not be a failure' do
    expect(result.failure?).to eq true
  end
end

shared_examples_for 'a critical' do
  let(:result) { described_class }
  it 'should be a critical' do
    expect(result.critical?).to eq true
  end
end

shared_examples_for 'a non-critical' do
  let(:result) { described_class }
  it 'should be a critical' do
    expect(result.critical?).to eq false
  end
end

describe DMTool::Result do
  let(:non_crit_constants) { [DMTool::Result::Success, DMTool::Result::Failure, DMTool::Result::NilResult] }
  let(:crit_constants) { [DMTool::Result::CriticalSuccess, DMTool::Result::CriticalFailure] }

  it 'should be instantiable' do
    expect { DMTool::Result.new }.to_not raise_error
  end

  it 'should have constants for failure, nil, success, crit fail, and crit success' do
    (crit_constants + non_crit_constants).each do |c|
      expect(c).to be_a(DMTool::Result)
    end
  end
end

describe DMTool::Result::Success do
  it_behaves_like 'a success'
  it_behaves_like 'a non-critical'
end

describe DMTool::Result::Failure do
  it_behaves_like 'a failure'
  it_behaves_like 'a non-critical'
end

describe DMTool::Result::NilResult do
  it_behaves_like 'a non-critical'
  it 'should be neither failure nor success' do
    expect(subject.success?).to eq false
    expect(subject.failure?).to eq false
  end
end

describe DMTool::Result::CriticalSuccess do
  it_behaves_like 'a success'
  it_behaves_like 'a critical'
  it 'should be a critical success' do
    expect(subject.critical_success?).to eq true
  end
end

describe DMTool::Result::CriticalFailure do
  it_behaves_like 'a failure'
  it_behaves_like 'a critical'
  it 'should be a critical failure' do
    expect(subject.critical_failure?).to eq true
  end
end

