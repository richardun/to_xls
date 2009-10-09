class Array
  
  def to_xls(options = {})
    output = '<?xml version="1.0" encoding="UTF-8"?><Workbook xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet" xmlns:html="http://www.w3.org/TR/REC-html40" xmlns="urn:schemas-microsoft-com:office:spreadsheet" xmlns:o="urn:schemas-microsoft-com:office:office"><Worksheet ss:Name="Sheet1"><Table>'
    
    if self.any?
      
      columns = options[:columns] ? options[:columns] : self.first.keys.map { |c| c.to_sym }
      
      if columns.any?
        unless options[:headers] == false
          output << '<Row>'
          columns.each { |column| output << "<Cell><Data ss:Type=\"String\">#{options[:upcase] ? column.to_s.humanize.upcase : column.to_s.humanize}</Data></Cell>" }
          output << '</Row>'
        end    

        self.each do |item|
          output << '<Row>'
          columns.each { |column| output << "<Cell><Data ss:Type=\"#{item[column].kind_of?(Integer) ? 'Number' : 'String'}\">#{item[column]}</Data></Cell>" }
          output << '</Row>'
        end
      end
    end
    
    output << '</Table></Worksheet></Workbook>'
  end
  
end