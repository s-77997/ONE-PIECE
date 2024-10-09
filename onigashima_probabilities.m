%初手に鬼ヶ島がある確率

function probabilities = onigashima_probabilities()
    % パラメータ設定
    total_cards = 50;  % カードの総数
    total_onigashima = 4;  % 鬼ヶ島カードの数
    first_draw = 5;  % 最初に引くカード枚数
    second_draw_firstmove = 6;  % 先手でマリガン後2ターン目までに引くカード枚数
    second_draw_secondmove = 7;  % 後手でマリガン後2ターン目までに引くカード枚数
    second_draw_life_secondmove = 8;  % 後手でマリガン後2ターン目までに引くカード枚数+ライフ1枚
    
    % 最初に鬼ヶ島を1枚以上引く確率
    p_first_draw = 1 - hypergeocdf(0, total_cards, total_onigashima, first_draw);
    
    % 先手: 0鬼ヶ島なら6枚引き直して1枚以上の確率
    p_firstmove_redraw = p_first_draw + (1-p_first_draw) * (1 - hypergeocdf(0, total_cards, total_onigashima, second_draw_firstmove));
    
    % 後手: 0鬼ヶ島なら7枚引き直して1枚以上の確率
    p_secondmove_redraw =  p_first_draw + (1-p_first_draw) * (1 - hypergeocdf(0, total_cards, total_onigashima, second_draw_secondmove));
    
     % 後手: 0鬼ヶ島なら8枚引き直して1枚以上の確率
    p_secondmove_redraw_life =  p_first_draw + (1-p_first_draw) * (1 - hypergeocdf(0, total_cards, total_onigashima, second_draw_life_secondmove));
    
    % 結果の表示
    probabilities.p_first_draw = p_first_draw;
    probabilities.p_firstmove_redraw = p_firstmove_redraw;
    probabilities.p_secondmove_redraw = p_secondmove_redraw;
    probabilities.p_secondmove_redraw_life = p_secondmove_redraw_life;
    
    fprintf('最初に鬼ヶ島が1枚以上ある確率: %.4f\n', p_first_draw);
    fprintf('先手マリガン後2ターン目までに1枚以上鬼ヶ島を引く確率 (6枚引き直し): %.4f\n', p_firstmove_redraw);
    fprintf('後手マリガン後2ターン目までに1枚以上鬼ヶ島を引く確率 (7枚引き直し): %.4f\n', p_secondmove_redraw);
    fprintf('後手マリガン後2ターン目までにライフを受けた場合1枚以上鬼ヶ島を引く確率 (8枚引き直し): %.4f\n', p_secondmove_redraw_life);

    % プロット
    labels = {'初手5枚', '先手6枚', '後手7枚', '後手8枚（ライフ）'};
    probabilities_values = [p_first_draw, p_firstmove_redraw, p_secondmove_redraw, p_secondmove_redraw_life];
    
    figure;
    bar(probabilities_values);
    set(gca, 'XTickLabel', labels);
    ylabel('確率');
    title('鬼ヶ島を1枚以上引ける確率');
    ylim([0 1]);
% グリッドを表示
    grid on;

end

% Hypergeometric分布のCDF (累積分布関数)
function p = hypergeocdf(k, N, K, n)
    % k: 引く枚数中の鬼ヶ島カード数 (ここでは0)
    % N: 全カード数
    % K: 鬼ヶ島カード数
    % n: 引く枚数
    p = hygecdf(k, N, K, n);
end
