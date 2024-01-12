puts "メニュー選択"
puts "→ 1(新規でメモを作成) / 2(既存のメモを編集) ※半角入力してください"

menu = gets.to_i

until menu == 1 || menu == 2 do
    puts "※メニュー選択エラー 再度メニュー選択してください"
    puts "→ 1(新規でメモを作成) / 2(既存のメモを編集) ※半角入力してください"

    menu = gets.to_i
end

if menu == 1
    puts "新規でメモを作成します"
    puts "新規で作成するファイル名を拡張子を除いて入力してください"

    file_name = gets.chomp

    while file_name.empty?
            puts "入力エラーです。再度ファイル名を拡張子を除いて入力してください"
            file_name = gets.chomp
    end

    puts "ファイル名『#{file_name}』にメモしたい内容を入力してください"
    puts "入力が完了したら Ctrl + D を押してください"

    file_content = readlines

    puts "※内容は以下でよろしいでしょうか？"
    puts "----------"
    puts file_content
    puts "----------"
    puts "→1(OK!) / 2(再入力) ※半角入力してください"
    
    file_content_confirm = gets.to_i

    until file_content_confirm == 1 do
        if file_content_confirm != 2 
            puts "※入力エラー"
        end

        puts "ファイル名『#{file_name}』にメモしたい内容を入力してください"
        puts "入力が完了したら Ctrl + D を押してください"
        
        file_content = readlines

        puts "※内容は以下でよろしいでしょうか？"
        puts "----------"
        puts file_content
        puts "----------"
        puts "→1(OK!) / 2(再入力) ※半角入力してください"

        file_content_confirm = gets.to_i

        until file_content_confirm == 1 || file_content_confirm == 2 do
            puts "※入力エラー　再度入力してください"
            puts "→1(OK!) / 2(再入力) ※半角入力してください"
            file_content_confirm = gets.to_i
        end
    end

    len = file_content.length
    i = 0
    while i < len
        file_content[i] = file_content[i].chomp
        i += 1
    end

    require "csv"
    CSV.open("#{file_name}.csv","w") do |csv|
        csv.puts file_content
    end

    puts "メモ『#{file_name}.csv』が作成されました！"

else 
    puts "編集を行いたいファイル名を拡張子を除いて入力してください"

    edit_file_name = gets.chomp

    begin 
        puts "ファイル名『#{edit_file_name}』"
        
        require "csv"
        edit_file_content = CSV.read("#{edit_file_name}.csv")
        puts "----------"
        puts edit_file_content
    rescue
        puts "指定されたファイルが見つかりません"
        puts "編集を行いたいファイル名を再度入力してください"
        edit_file_name = gets.chomp
        retry
    end

    puts "----------"

    puts "メモの内容を編集してください"
    puts "入力が完了したら Ctrl + D を押してください"

    file_content = readlines

    puts "※内容は以下でよろしいでしょうか？"
    puts "----------"
    puts file_content
    puts "----------"
    puts "→1(OK!) / 2(再入力) ※半角入力してください"

    edit_file_content_confirm = gets.to_i

    until edit_file_content_confirm == 1 do
        if edit_file_content_confirm != 2
            puts "※入力エラー"
        end

        puts "メモの内容を編集してください"
        puts "入力が完了したら Ctrl + D を押してください"

        file_content = readlines

        puts "※内容は以下でよろしいでしょうか？"
        puts "----------"
        puts file_content
        puts "----------"
        puts "→1(OK!) / 2(再入力) ※半角入力してください"

        edit_file_content_confirm = gets.to_i

        until edit_file_content_confirm == 1 || edit_file_content_confirm == 2 do
            puts "※入力エラー　再度入力してください"
            puts "→1(OK!) / 2(再入力) ※半角入力してください"
            edit_file_content_confirm = gets.to_i
        end
    end

    len = file_content.length
    i = 0
    while i < len
        file_content[i] = file_content[i].chomp
        i += 1
    end

    require "csv"
    CSV.open("#{edit_file_name}.csv","w") do |csv|
        csv.puts file_content
    end

    puts "メモの内容は更新されました！"

end
