require_relative "../human"

RSpec.describe Human do
  describe "#greet" do
    context "when mocking `#greet`" do
      it "return nil by default" do
        human_mock = double("human")
        allow(human_mock).to receive(:greet)
        allow(Human).to receive(:new).and_return(human_mock)

        expect(Human.new.greet).to eq nil
      end

      # and_returnで返り値の定義
      it "return 'goodbye' using `#and_return`" do
        human_mock = double("human")
        allow(human_mock).to receive(:greet).and_return("goodbye")
        allow(Human).to receive(:new).and_return(human_mock)

        expect(Human.new.greet).to eq "goodbye"
      end

      # and_returnではなく、ブロックで返り値の定義
      it "return 'goodbye' using block" do
        human_mock = double("human")
        allow(human_mock).to receive(:greet) { "goodbye" }
        allow(Human).to receive(:new).and_return(human_mock)

        expect(Human.new.greet).to eq "goodbye"
      end

      # doubleメソッドで応答するメソッドの定義もできる
      # この書き方の方がシンプルで良い
      it "return 'goodbye' using `#double`" do
        human_mock = double("human", greet: "goodbye")
        allow(Human).to receive(:new).and_return(human_mock)

        expect(Human.new.greet).to eq "goodbye"
      end

      # メソッドが呼び出されていないことを確認する
      it "Human instance doesn't receive `#greet`" do
        human_mock = double("human")
        allow(Human).to receive(:new).and_return(human_mock)

        expect(human_mock).not_to receive(:greet)
      end

      # メソッドが呼び出されたことを確認する
      it "Human instance receives `#greet`" do
        human_mock = double("human")
        allow(Human).to receive(:new).and_return(human_mock)

        expect(human_mock).to receive(:greet)
        Human.new.greet
      end
    end
  end

  describe "#eat" do
    context "when mocking `#eat`" do
      # 引数の指定をする。指定された引数以外が渡されるとfailする
      it "return nil by default" do
        human_mock = double("human")
        allow(human_mock).to receive(:eat).with("egg")
        allow(Human).to receive(:new).and_return(human_mock)

        expect(Human.new.eat("egg")).to eq nil
      end

      # 引数は取るが、値そのものは何でも良い場合
      it "return nil by default using `anything`" do
        human_mock = double("human")
        allow(human_mock).to receive(:eat).with(anything)
        allow(Human).to receive(:new).and_return(human_mock)

        # どんな引数でもOKとなる
        expect(Human.new.eat("egg")).to eq nil
        expect(Human.new.eat("bread")).to eq nil
        expect(Human.new.eat("rice")).to eq nil
      end
    end
  end

  describe "#sleep" do
    context "when mocking `#sleep`" do
      # 例外のテスト。`Human#sleep`はまれに例外が発生するメソッド
      it "should raise error" do
        human_mock = double("human")
        allow(human_mock).to receive(:sleep).and_raise("a")
        allow(Human).to receive(:new).and_return(human_mock)

        # ここブロックじゃないといけないらしい
        expect{ Human.new.sleep }.to raise_error(RuntimeError)
      end
    end
  end
end
