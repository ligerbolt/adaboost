#coding utf-8

# 弱識別器クラス
class WeakLearner

  attr_accessor :ref_num, :threshold, :sign, :weight, :error

  # 正クラス、負クラス識別定数
  POSITIVE_LABEL = 1.freeze
  NEGATIVE_LABEL = -1.freeze
  ERROR_THRESHOLD = 0.5

  def initialize(threshold, ref_num, sign = POSITIVE_LABEL)
    @threshold = threshold
    @ref_num = ref_num
    @sign = sign
  end

  # 弱識別器式出力
  def print_formula
    puts "--------------------------------------------------------"
    puts "weight    : #{@weight}"
    puts "formula   : #{@sign} * value > #{@sign} * #{@threshold}"
    puts "target element : #{@ref_num}"
  end

  # ２クラス識別（値入力）
  def classify_value(value)
    (value * @sign) > (@threshold * @sign) ? POSITIVE_LABEL : NEGATIVE_LABEL
  end

  # ２クラス識別（ベクトル入力）
  def classify_vector(vector)
    classify_value(vector[@ref_num])
  end

  # 識別スコア値出力
  def calc_score(value)
    value.instance_of?(Array) ?
      @weight * classify_vector(value) : @weight * classify_value(value)
  end

  # 荷重係数算出
  def calc_weight
    @weight = Math.log((1.0 - @error) / @error) * 0.5
  end

  # エラー率算出
  def calc_error(datasets)
    @error = datasets.inject(0) do |sum, data|
      data.label != classify_vector(data.vector) ? sum + data.weight : sum
    end

  # 閾値越えた場合は符号反転
    if @error > ERROR_THRESHOLD
      @sign = NEGATIVE_LABEL
      @error = 1.0 - @error
    end
  end
end
