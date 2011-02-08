class Entry < ActiveRecord::Base
  cattr_reader :per_page
  @@per_page = 30

  def short_definition
    self.defs_array.first 
  end

  def pos
    self.definition.match(/POS: (.)/)[1]
  end

  def defs_array
    p = self.definition
    t = p.scan(/\[(\d+)\]([^\[]+)/).map{|x| x[1].strip}
    t.empty? || t == nil ? [p] : t
  end

  def to_html(root_url = "")
      begin
        WadokuGrammar.parse(self.definition).to_html.gsub("<<<ROOT_URL>>>",root_url).html_safe
      rescue => e
        #"FFF " + pos_html(genus_html(clean_markup(short_definition)))
        "parsing failed... #{self.definition}"
      end
  end

  def full_html(root_url = "")
    "<span class='writing'><ruby><rb>#{self.writing}</rb><rp> (</rp><rt>#{self.kana}</rt><rp>) </rp></ruby></span> : #{self.to_html(root_url)}".html_safe
  end

  alias :short_html :to_html

  def defs_array_html
    p = defs_array
    p.map{|x| 
      begin
        WadokuGrammar.parse(x).html.html_safe
      rescue => e
        #"FFF " + pos_html(genus_html(clean_markup(short_definition)))
        "parsing failed... #{x}"
      end
    }

  end

  def related
    if self.entry_relation["HE"] then
      res = Entry.where(:entry_relation => self.writing + "\n")
    else
      res = Entry.where(:writing => self.entry_relation.strip)
    end
    res || []
  end

  private

  CLEAN_REGEXPS = [/\{<.+?>\}/,/\(<.+?>\)/,/^\S/]

  def pos_and_def
    self.definition.match(/^(\(.+?\))(.*)/)[1..-1] 
  end

  def genus_html(defi)
    defi.gsub(/<Gen.: (\w+)>/) do |mat|
      " <em>#{$1}</em>"
    end
  end

  def pos_html(defi)
    defi.gsub(/\(<POS: (\w+).>\)/) do |mat|
      " <strong>#{$1}</strong>"
    end
  end

  def clean_markup(defi)
    t = defi.dup
    CLEAN_REGEXPS.each do |reg|
      t.gsub!(reg,"")
    end
    t
  end

end
