#coding utf-8

# 学習データ格納クラス
class Dataset

  attr_reader :vector, :label, :weight

  def initialize(label, vector, weight = 1.0)
    @label = label
    @vector = vector
    @weight = weight
  end

  # 荷重係数初期化
  def init_weight(size)
    @weight = 1.0 / size
  end

  # 荷重係数更新
  def update_weight(weak)
    @weight =
      @weight * Math.exp(-1.0 * weak.calc_score(@vector) * @label)
  end

  # 荷重係数正規化
  def normalize_weight(norm)
    @weight /= norm
  end
end
