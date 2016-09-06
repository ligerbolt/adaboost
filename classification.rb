#coding utf-8
require_relative "dataset"
require_relative "weak_learner"

classifier = []
datasets = []

# 外部ファイルより識別器パラメータ取得＆構築
File::open("classifier.dat") do |file|
  file.each_line do |line|
    threshold, ref_num, sign, weight = line.split.map(&:to_f)
    classifier << WeakLearner.new(threshold, ref_num.to_i, sign, weight)
  end
end

# 識別データ読込
File::open("datasets.dat") do |file|
  file.each_line do |line|
    label, *vector = line.split.map(&:to_f)
    datasets << Dataset.new(label.to_i, vector)
  end
end

# 識別データを識別器にかけ分類スコア算出
datasets.each_with_index(1) do |data, i|
  score =
    classifier.inject(0) { |sum, weak| sum + weak.calc_score(data.vector) }
  puts "------- data #{i} -------"
  puts "Associate data label : #{data.label}"
  puts "Classification score : #{score}"
end
