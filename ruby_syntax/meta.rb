class Meta
  def method_missing(method_name, *args, &block)
    if method_name =~ /get_.*/
      puts 'method get ...'
    else
      super
    end
  end

  %w[method1 method2 method3].each do |method_name|
    define_method method_name do
      puts "Method #{method_name}"
    end
  end
end
