%サーチのヒット率

function prob = search_probability()
    total_cards_origin = 50; % 全体のカード枚数
    total_cards = total_cards_origin - 1; % 全体のカード枚数-サーチカード自身
    target_cards = 16; % サーチ先のカード枚数
    selected_cards = 5; % サーチで見れるカード枚数

    % 対象のカードが1枚も選ばれない確率を計算
    non_target_combinations = nchoosek(total_cards - target_cards, selected_cards);
    total_combinations = nchoosek(total_cards, selected_cards);
    
    % 対象のカードが1枚も選ばれない確率
    prob_no_target = non_target_combinations / total_combinations;
    
    % 1枚以上含まれる確率は、1から上記を引く
    prob = 1 - prob_no_target;
end
