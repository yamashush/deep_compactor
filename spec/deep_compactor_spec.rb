# frozen_string_literal: true

RSpec.describe DeepCompactor do
  using described_class
  using RSpec::Parameterized::TableSyntax

  it "has a version number" do
    expect(DeepCompactor::VERSION).not_to be nil
  end

  describe "Array#deep_compact" do
    subject { source.deep_compact }

    where(:source, :compacted) do
      ["a", nil, [], ["aa", nil, []]] | ["a", [], ["aa", []]]
      ["a", "b", [], %w[aa bb cc]]    | ref(:source)
    end

    with_them do
      it "source be compacted" do
        expect(subject).to eq compacted
      end
    end
  end

  describe "Array#deep_compact!" do
    subject { source.deep_compact! }

    where(:source, :compacted, :result) do
      ["a", nil, [], ["aa", nil, []]] | ["a", [], ["aa", []]] | ref(:compacted)
      ["a", "b", [], %w[aa bb cc]]    | ref(:source)          | nil
    end

    with_them do
      it "source be compacted" do
        subject
        expect(source).to eq compacted
      end
      it "should be result" do
        expect(subject).to eq result
      end
    end
  end

  describe "Array#deep_compact_blank" do
    subject { source.deep_compact_blank }

    where(:source, :compacted) do
      ["a", nil, [], ["aa", nil, []]] | ["a", %w[aa]]
      ["a", "b", "c", %w[aa bb cc]]   | ref(:source)
    end

    with_them do
      it "source be compacted" do
        expect(subject).to eq compacted
      end
    end
  end

  describe "Array#deep_compact_blank!" do
    subject { source.deep_compact_blank! }

    where(:source, :compacted, :result) do
      ["a", nil, [], ["aa", nil, []]] | ["a", %w[aa]] | ref(:compacted)
      ["a", "b", "c", %w[aa bb cc]]   | ref(:source)  | nil
    end

    with_them do
      it "source be compacted" do
        subject
        expect(source).to eq compacted
      end
      it "should be result" do
        expect(subject).to eq result
      end
    end
  end

  describe "Hash#deep_compact" do
    subject { source.deep_compact }

    where(:source, :compacted) do
      { a: 1, b: nil, c: {}, d: { aa: 11, bb: nil, cc: {} } } | { a: 1, c: {}, d: { aa: 11, cc: {} } }
      { a: 1, b: 2, c: {}, d: { aa: 11, bb: 22, cc: {} } }    | ref(:source)
    end

    with_them do
      it "source be compacted" do
        expect(subject).to eq compacted
      end
    end
  end

  describe "Hash#deep_compact!" do
    subject { source.deep_compact! }

    where(:source, :compacted, :result) do
      { a: 1, b: nil, c: {}, d: { aa: 11, bb: nil, cc: {} } } | { a: 1, c: {}, d: { aa: 11, cc: {} } } | ref(:compacted)
      { a: 1, b: 2, c: {}, d: { aa: 11, bb: 22, cc: {} } }    | ref(:source)                           | nil
    end

    with_them do
      it "source be compacted" do
        subject
        expect(source).to eq compacted
      end
      it "should be result" do
        expect(subject).to eq result
      end
    end
  end

  describe "Hash#deep_compact_blank" do
    subject { source.deep_compact_blank }

    where(:source, :compacted) do
      { a: 1, b: nil, c: {}, d: { aa: 11, bb: nil, cc: {} } }                 | { a: 1, d: { aa: 11 } }
      { a: 1, b: 2, c: { aa: 11 }, d: { aa: 11, bb: 22, cc: { aaa: 111 } } }  | ref(:source)
    end

    with_them do
      it "source be compacted" do
        expect(subject).to eq compacted
      end
    end
  end

  describe "Hash#deep_compact_blank!" do
    subject { source.deep_compact_blank! }

    where(:source, :compacted, :result) do
      { a: 1, b: nil, c: {}, d: { aa: 11, bb: nil, cc: {} } }                | { a: 1, d: { aa: 11 } } | ref(:compacted)
      { a: 1, b: 2, c: { aa: 11 }, d: { aa: 11, bb: 22, cc: { aaa: 111 } } } | ref(:source)            | nil
    end

    with_them do
      it "source be compacted" do
        subject
        expect(source).to eq compacted
      end
      it "should be result" do
        expect(subject).to eq result
      end
    end
  end
end
