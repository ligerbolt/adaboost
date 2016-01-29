#coding utf-8
require_relative "dataset"
require_relative "weak_learner"

# 機械学習クラス
class Training

  # 定数宣言
  POSITIVE_LABEL = 1.freeze
  NEGATIVE_LABEL = -1.freeze

  def initialize(datasets = [])
    set_datasets(datasets)
  end

  # 学習用データセット取得
  def set_datasets(datasets)
    @datasets = datasets
    @vector_size = datasets[0].vector.size
    init_weights
  end


  # 学習実行（弱識別器生成）
  def build_classifier
    optimal_weak = ()
    @vector_size.times do |ref_num|

      # 弱識別器候補生成
      pre_weaks = create_weakleaener(ref_num)

      # 弱識別器候補のエラー率算出
      pre_weaks.each { |weak| weak.calc_error(@datasets) }

      # エラー率から最適な弱識別器であるか判定
      pre_weak =
        pre_weaks.sort { |x_weak, y_weak| x_weak.error <=> y_weak.error }.first
      if ref_num == 0 || pre_weak.error < optimal_weak.error
        optimal_weak = Marshal.load(Marshal.dump(pre_weak))
      end
    end

    # 弱識別器に付随する荷重係数算出
    optimal_weak.calc_weight

    # データに付随する荷重係数更新
    update_weights(optimal_weak)
    optimal_weak
  end

  private
  # データ付随の荷重係数初期化
  def init_weights
    @datasets.each { |data| data.init_weight(@datasets.size) }
  end

  # 弱識別器群生成（閾値関数の参照位置指定）
  def create_weakleaener(ref_num)
    pre_weaks = []
    @datasets.each do |data|
      threshold = data.vector[ref_num]
      pre_weaks << WeakLearner.new(threshold, ref_num)
    end
    pre_weaks
  end

  # データ付随の荷重係数更新
  def update_weights(weak)
    norm = @datasets.inject(0) do |sum, data|
      sum + data.update_weight(weak)
    end

    # 正規化した荷重係数を更新
    @datasets.each { |data| data.normalize_weight(norm) }
  end
end
