const pTag1 = document.querySelector('.first-parallel')
const pTag2 = document.querySelector('.second-parallel')
const pTag3 = document.querySelector('.third-parallel')
const pTag4 = document.querySelector('.forth-parallel')

const textArr1 = 'SAND - HORIZON - MIRAGE - PALM - OASIS -'.split(' ')
const textArr2 = 'ENDLESS DINING POSSIBILITIES ENDLESS DINING POSSIBILITIES'.split(' ')
const textArr3 = "ALL INCLUSIVE OCEANFRONT RESORT ALL INCLUSIVE OCEANFRONT RESORT".split(' ')
const textArr4 = 'ENDLESS DINING POSSIBILITIES ENDLESS DINING POSSIBILITIES'.split(' ')

let count1 = 0
let count2 = 0
let count3 = 0
let count4 = 0

initTexts(pTag1, textArr1)
initTexts(pTag2, textArr2)
initTexts(pTag3, textArr3)
initTexts(pTag4, textArr4)

function initTexts(element, textArray) {
  textArray.push(...textArray)
  for (let i = 0; i < textArray.length; i++) {
    element.innerText += `${textArray[i]}\u00A0\u00A0\u00A0\u00A0`
  }
}

function marqueeText(count, element, direction) {
  if (count > element.scrollWidth / 2) {
    element.style.transform = `translate3d(0, 0, 0)`
    count = 0
  }
  element.style.transform = `translate3d(${direction * count}px, 0, 0)`

  return count
}

function animate() {
  count1++
  count2++
  count3++
  count4++

  count1 = marqueeText(count1, pTag1, -1)
  count2 = marqueeText(count2, pTag2, 1)
  count3 = marqueeText(count3, pTag3, -1)
  count4 = marqueeText(count4, pTag4, 1)

  window.requestAnimationFrame(animate)
}

function scrollHandler() {
  count1 += 15
  count2 += 15
  count3 += 15
  count4 += 15
}

window.addEventListener('scroll', scrollHandler)
animate()