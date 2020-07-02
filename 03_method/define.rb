# Q1.
# 次の動作をする A1 class を実装する
# - "//" を返す "//"メソッドが存在すること

# Q2.
# 次の動作をする A2 class を実装する
# - 1. "SmartHR Dev Team"と返すdev_teamメソッドが存在すること
# - 2. initializeに渡した配列に含まれる値に対して、"hoge_" をprefixを付与したメソッドが存在すること
# - 2で定義するメソッドは下記とする
#   - 受け取った引数の回数分、メソッド名を繰り返した文字列を返すこと
#   - 引数がnilの場合は、dev_teamメソッドを呼ぶこと

# Q3.
# 次の動作をする OriginalAccessor モジュール を実装する
# - OriginalAccessorモジュールはincludeされたときのみ、my_attr_accessorメソッドを定義すること
# - my_attr_accessorはgetter/setterに加えて、boolean値を代入した際のみ真偽値判定を行うaccessorと同名の?メソッドができること

class A1
  define_method("//") do
    "//"
  end
end

class A2
  def initialize(args)
    args.each do |arg, i|
      method_name = "hoge_#{arg}"
      define_singleton_method(method_name) do |num|
        num.nil? ? dev_team : method_name * num
      end
    end
  end

  def dev_team
    'SmartHR Dev Team'
  end
end

module OriginalAccessor
  def self.included(mod)
    mod.define_singleton_method("my_attr_accessor") do |attr|
      define_method attr do
        @attr
      end

      define_method "#{attr}=" do |value|
        if [true, false].include?(value) && !respond_to?("#{attr}?")
          define_singleton_method "#{attr}?" do
            @attr == true
          end
        end
        @attr = value
      end
    end
  end
end
