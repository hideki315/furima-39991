window.addEventListener('turbo:load', () => {
  const priceInput = document.getElementById("item-price");
  if (priceInput) {
    priceInput.addEventListener("input", () => {
      // 販売価格を取得
      var price = parseFloat(priceInput.value);

      // 販売手数料と販売利益の初期値を設定
      var fee = 0;
      var profit = 0;

      // 販売価格が入力されている場合のみ計算を行う
      if (!isNaN(price)) {
        // 販売手数料の計算（10%）
        fee = Math.floor(price * 0.1);
        // 販売利益の計算
        profit = price - fee;
      }

      // 販売手数料を表示
      document.getElementById('add-tax-price').innerHTML = fee.toLocaleString();

      // 販売利益を表示
      document.getElementById('profit').innerHTML = profit.toLocaleString();
    });
  };
});
