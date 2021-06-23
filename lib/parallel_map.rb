class ParallelMap
  def self.parallel_map(array, &block)
    self.class.define_method "foo", Ractor.make_shareable(Proc.new(&block))
    16.times do |i|
      Ractor.new(Ractor.current, i) do |main_ractor, i|
        loop do
          data = main_ractor.take
          result = ParallelMap.foo(data[1])
          main_ractor.send([data[0], result])
        end
      end
    end

    puts "yielding data to ractors"
    array.each_with_index do |el, i|
      Ractor.yield([i, el])
    end

    puts "gathering results"

    output = Array.new(array.length)

    array.length.times do |i|
      result = Ractor.main.take
      output[result[0]] = result[1]
    end
    output
  end
end
