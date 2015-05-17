RSpec.describe String do
  it 'removes duplicate spaces' do
    expect('i like   dogs'.prep).to eq 'i like dogs'
  end

  it 'removes duplicate commas' do
    expect('woof, arf,, arroo'.prep).to eq 'woof, arf, arroo'
  end

  it 'removes leading and trailing whitespace' do
    expect('   charles is a good boy  '.prep).to eq 'charles is a good boy'
  end

  it 'strips and squeezes all at once' do
    expect('  oodles of poodles   and a puppy,, too!  '.prep).to eq 'oodles of poodles and a puppy, too!'
  end

end
