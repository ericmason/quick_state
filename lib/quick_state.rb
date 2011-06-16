class QuickState
  attr_accessor :autosave
  
  def initialize(file_path=nil)
    @file_path = file_path || "#{$0}.state"
    if File.exist?(@file_path)
      @data = Marshal.load(File.read(@file_path))
    else
      @data = {}
    end
  end
  
  def [](key)
    @data[key]
  end
  
  def []=(key,val)
    @data[key] = val
    save if autosave
    val
  end
  
  def save
    File.open(@file_path, "w") {|f| Marshal.dump(@data, f); f.fsync}
  end
  
  def autosave!
    self.autosave = true
    self
  end
end
