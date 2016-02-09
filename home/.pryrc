# === EDITOR ===
Pry.editor = 'vim'

## Useful Collections
def a_array
  (1..6).to_a
end

def a_hash
  {hello: "world", free: "of charge"}
end

# Pry.config.pager = true
# Pry.config.editor = "emacs"
Pry.config.color = true
Pry.config.prompt = Pry::NAV_PROMPT
#Pry.prompt = [proc { |obj, nest_level, _| "#{RUBY_VERSION} (#{obj}):#{nest_level} > " }, proc { |obj, nest_level, _| "#{RUBY_VERSION} (#{obj}):#{nest_level} * " }]

Pry.config.commands.alias_command "h", "hist -T 20", desc: "Last 20 commands"
Pry.config.commands.alias_command "hg", "hist -T 20 -G", desc: "Up to 20 commands matching expression"
Pry.config.commands.alias_command "hG", "hist -G", desc: "Commands matching expression ever used"
Pry.config.commands.alias_command "hr", "hist -r", desc: "hist -r <command number> to run a command"
# == Pry-Nav - Using pry as a debugger ==
Pry.commands.alias_command 'c', 'continue' rescue nil
Pry.commands.alias_command 's', 'step' rescue nil
Pry.commands.alias_command 'n', 'next' rescue nil
Pry.commands.alias_command 'r!', 'reload!' rescue nil

begin
  require 'awesome_print'
  # Pry.config.print = proc { |output, value| output.puts value.ai }
  AwesomePrint.pry!
rescue LoadError => err
  puts "no awesome_print :("
end

my_hook = Pry::Hooks.new.add_hook(:before_session, :add_dirs_to_load_path) do
  # adds the directories /spec and /test directories to the path if they exist and not already included
  dir = `pwd`.chomp
  dirs_added = []
  %w(spec test).map{ |d| "#{dir}/#{d}" }.each do |p|
    if File.exist?(p) && !$:.include?(p)
      $: << p
      dirs_added << p
    end
  end
  puts "Added #{ dirs_added.join(", ") } to load path in ~/.pryrc." if dirs_added.present?
end

my_hook.exec_hook(:before_session)

puts "Loaded ~/.pryrc"
puts
puts "Helpful shortcuts:"
puts "h  : hist -T 20       Last 20 commands"
puts "hg : hist -T 20 -G    Up to 20 commands matching expression"
puts "hG : hist -G          Commands matching expression ever used"
puts "hr : hist -r          hist -r <command number> to run a command"
puts
puts "c  : continue"
puts "s  : step"
puts "n  : next"
puts "r!  : reload!"
puts
puts "Samples variables"
puts "a_array  :  [1, 2, 3, 4, 5, 6]"
puts "a_hash   :  { hello: \"world\", free: \"of charge\" }"
puts
puts "Helpful modules: Where"

module Where
  class <<self
    attr_accessor :editor
    
    def is_proc(proc)
      source_location(proc)
    end
    
    def is_method(klass, method_name)
      source_location(klass.method(method_name))
    end
    
    def is_instance_method(klass, method_name)
      source_location(klass.instance_method(method_name))
    end
    
    def are_methods(klass, method_name)
      are_via_extractor(:method, klass, method_name)
    end
    
    def are_instance_methods(klass, method_name)
      are_via_extractor(:method, klass, method_name)
    end
    
    def is_class(klass)
      methods = defined_methods(klass)
      file_groups = methods.group_by{|sl| sl[0]}
      file_counts = file_groups.map do |file, sls|
        lines = sls.map{|sl| sl[1]}
        count = lines.size
        line = lines.min
        {file: file, count: count, line: line}
      end
      file_counts.sort_by!{|fc| fc[:count]}
      source_locations = file_counts.map{|fc| [fc[:file], fc[:line]]}
      source_locations
    end
    
    # Raises ArgumentError if klass does not have any Ruby methods defined in it.
    def is_class_primarily(klass)
      source_locations = is_class(klass)
      if source_locations.empty?
        methods = defined_methods(klass)
        raise ArgumentError, (methods.empty? ?
          "#{klass} has no methods" :
          "#{klass} only has built-in methods (#{methods.size} in total)"
        )
      end
      source_locations[0]
    end
    
    def edit(location)
      unless location.kind_of?(Array)
        raise TypeError,
          "only accepts a [file, line_number] array"
      end
      editor[*location]
      location
    end
    
  private
  
    def source_location(method)
      method.source_location || (
        method.to_s =~ /: (.*)>/
        $1
      )
    end
    
    def are_via_extractor(extractor, klass, method_name)
      methods = klass.ancestors.map do |ancestor|
        method = ancestor.send(extractor, method_name)
        if method.owner == ancestor
          source_location(method)
        else
          nil
        end
      end
      methods.compact!      
      methods
    end
    
    def defined_methods(klass)
      methods = klass.methods(false).map{|m| klass.method(m)} +
        klass.instance_methods(false).map{|m| klass.instance_method(m)}
      methods.map!(&:source_location)
      methods.compact!
      methods
    end
  end
  
  TextMateEditor = lambda do |file, line|
    `mate "#{file}" -l #{line}`
  end
  
  NoEditor = lambda do |file, line|
  end
  
  @editor = TextMateEditor
end

def where_is(klass, method = nil)
  Where.edit(if method
    begin
      Where.is_instance_method(klass, method)
    rescue NameError
      Where.is_method(klass, method)
    end
  else
    Where.is_class_primarily(klass)
  end)
end

if __FILE__ == $0
  class World
    def self.carmen
    end
  end
  
  where_is(World, :carmen)
end
