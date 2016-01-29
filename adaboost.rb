#######################################
# Adaboost サンプルプログラム
#######################################
#coding utf-8
require_relative "dataset"
require_relative "training"
require_relative "weak_learner"

# 生成する弱識別器数
WEAK_COUNT = 100.freeze
POSITIVE_LABEL = 1.freeze
NEGATIVE_LABEL = -1.freeze

datasets = []
classifier = []

# 外部ファイルよりラベル付学習データ取得
File::open("datasets.dat") do |file|
  file.each_line do |line|
    label, *vector = line.split.map(&:to_f)
    datasets << Dataset.new(label.to_i, vector)
  end
end

# 学習オブジェクト生成
l_machine = Training.new(datasets)

# 弱識別器生成数分だけループ処理実行
WEAK_COUNT.times do |i|
  correct = 0
  classifier << l_machine.build_classifier

  # 学習データを識別器にかけ正解率算出
  datasets.each do |data|
    score =
      classifier.inject(0) { |sum, weak| sum + weak.calc_score(data.vector) }

    if score >= 0.0 && data.label == POSITIVE_LABEL
      correct += 1
    elsif score < 0.0 && data.label == NEGATIVE_LABEL
      correct += 1
    end
  end
  puts "TEST_CORRECT : #{correct} / #{datasets.size}"
  if correct == datasets.size
    puts "weak_count: #{i}"
    break
  end
end

