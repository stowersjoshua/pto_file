require 'delegate'

class PtoFile < DelegateClass(File)
  def initialize(filename = 'project.pto', mode='r', **options)
    @file = File.open(filename, mode)

    if block_given?
      begin
        yield(@file)
      ensure
        @file.close
      end
    end

    super(@file)
  end
end
