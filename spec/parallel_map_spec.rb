require_relative "../lib/parallel_map"

describe ParallelMap do
  it "can map an array" doœ
    expect(ParallelMap.parallel_map([1, 2, 3]) { |i| i + 1 }).to eq([2, 3, 4])
  end
end
