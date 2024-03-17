let payjpInstance;


const pay = () => {
  const publicKey = gon.public_key;
  const payjpInstance = Payjp(publicKey);
  const elements = payjpInstance.elements();
  const numberElement = elements.create('cardNumber');
  const expiryElement = elements.create('cardExpiry');
  const cvcElement = elements.create('cardCvc');

  numberElement.mount('#number-form');
  expiryElement.mount('#expiry-form');
  cvcElement.mount('#cvc-form');
  const form = document.getElementById('charge-form');
  form.addEventListener("submit", (e) => {
    payjpInstance.createToken(numberElement).then(function (response) {
      if (response.error) {
      } else {
        const renderDom = document.getElementById("charge-form");
        const token = response.id;
        const tokenObj = `<input value=${token} type="hidden" name='token'>`;
        renderDom.insertAdjacentHTML("beforeend", tokenObj);
      }
      numberElement.clear();
      expiryElement.clear();
      cvcElement.clear();
      document.getElementById("charge-form").submit();
    });
    e.preventDefault();
  });
};

window.addEventListener("turbo:load", pay);
window.addEventListener("turbo:render", pay);
