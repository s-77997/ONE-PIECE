%サーチのヒット率

function search_probability()
    total_cards_origin = 50; % 全体のカード枚数
    total_cards = total_cards_origin - 1; % 全体のカード枚数 - サーチカード自身
    selected_cards = 5; % サーチで見れるカード枚数

    % 結果を格納するための配列を初期化
    probabilities = zeros(1, total_cards + 1); % 0からtotal_cardsまでの確率

    % target_cards を 0 から total_cards まで動かして確率を計算
    for target_cards = 0:total_cards
        % カードが1枚も対象カードを含まない場合を計算
        if total_cards - target_cards >= selected_cards
            % 対象のカードが1枚も選ばれない確率を計算
            non_target_combinations = nchoosek(total_cards - target_cards, selected_cards);
            total_combinations = nchoosek(total_cards, selected_cards);

            % 対象のカードが1枚も選ばれない確率
            prob_no_target = non_target_combinations / total_combinations;
        else
            % 対象カードが多すぎて、1枚も含まれないケースが存在しない
            prob_no_target = 0;
        end

        % 1枚以上含まれる確率は、1から上記を引く
        probabilities(target_cards + 1) = 1 - prob_no_target;
    end

    % グラフを作成
    figure;
    plot(0:total_cards, probabilities, '-o');
    xlabel('サーチ先のカードの枚数');
    ylabel('サーチのヒット率');
    title('サーチ先のカードの枚数とヒット率');
    grid on;
end
