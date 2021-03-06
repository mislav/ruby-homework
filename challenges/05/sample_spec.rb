describe "Enumerable#split_up" do
  let(:numbers_list) { 1.upto(10) }
  let(:numbers_hash) { { one: 1, two: 2, three: 3, four: 4 } }
  let(:pad)          { [:a, :b, :c] }

  it "splits up a collection in slices with step and pad" do
    numbers_list.split_up(length: 2, step: 3, pad: pad).should eq [[1, 2],
                                                                   [4, 5],
                                                                   [7, 8],
                                                                   [10, :a]]

    numbers_hash.split_up(length: 2, step: 3, pad: pad).should eq [[[:one, 1], [:two, 2]],
                                                                   [[:four, 4], :a]]
  end

  it "splits up a collection in slices just with length" do
    numbers_list.split_up(length: 3).should eq [[1, 2, 3], [4, 5, 6],
                                                [7, 8, 9], [10]]

    numbers_list.split_up(length: 2).should eq [[1, 2], [3, 4],
                                                [5, 6], [7, 8],
                                                [9, 10]]
  end

  it "splits up a collection in slices with step" do
    numbers_list.split_up(length: 2, step: 3).should eq [[1, 2], [4, 5],
                                                         [7, 8], [10]]

    numbers_list.split_up(length: 2, step: 4).should eq [[1, 2], [5, 6],
                                                         [9, 10]]
  end

  it "splits up a collection in slices with pad" do
    numbers_list.split_up(length: 3, pad: pad).should eq [[1, 2, 3], [4, 5, 6],
                                                          [7, 8, 9], [10, :a, :b]]
  end

  it "splits up a collection with block given" do
    numbers_list.split_up(length: 2) { |slice| slice << :! }.should eq [[1, 2, :!],
                                                                        [3, 4, :!],
                                                                        [5, 6, :!],
                                                                        [7, 8, :!],
                                                                        [9, 10, :!]]
  end
end
