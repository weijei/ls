
def prompt(message)
  Kernel.puts("=> #{message}")
end


def test_method
  prompt('test message')
end

test_method           # second, try invoking "test_method" here