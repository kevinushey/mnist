
plot.mnist <- function(x = mnist$test$x, label = mnist$test$y + 1, model = prcomp(mnist$train$x),
					   predictions = predict(model, x)[,1:2], reconstructions = tcrossprod(predictions, model$rotation[,1:2]),
					   show.reconstructions = TRUE,
					   highlight.digits = c(11, 3, 2, 91, 20, 188, 92, 1, 111, 13),
					   digits.col = c("#FF0000FF", "#0000FFFF", "#964B00FF", "#FF00FFFF", "#00AAAAFF", "#00EE00FF", "#000000FF", "#000000FF", "#AAAAAAFF", "#FF9900FF"),
					   digits.alphas.reverse = c(FALSE, TRUE)[c(1, 1, 1, 1, 1, 1, 2, 1, 1, 1)],
					   pch = 21,
					   pch.col = c("black", "white")[c(1, 2, 1, 1, 1, 1, 1, 2, 1, 1)],
					   pch.bg = c("#FF0000FF", "#0000FFFF", "#964B00FF", "#FF00FFFF", "#00AAAAFF", "#00EE00FF", "#FFFFFFFF", "#000000FF", "#AAAAAAFF", "#FF9900FF"),
					   cex = 1.5,
					   cex.axis = .5,
					   cex.lab = .5,
					   cex.highlight = 2.5,
					   xlab = "Node 1",
					   ylab = "Node 2",
					   xlim = NULL,
					   ylim = NULL,
					   ncol = 10,
					   ...
					   ) {
	
	n.highlight <- length(highlight.digits)
	layout(cbind(seq_along(highlight.digits), matrix(1 + n.highlight + ifelse(show.reconstructions, n.highlight, 0), nrow=n.highlight, ncol=ncol), if (show.reconstructions) seq_along(highlight.digits) + n.highlight))
	
	opar <- par(cex=cex)
	
	alphas.gen <- expand.grid(c(0:9, LETTERS[1:6]), c(0:9, LETTERS[1:6]))
	alphas <- paste(alphas.gen[,2], alphas.gen[,1], sep="")
	
	sapply(seq_along(highlight.digits), function(i) {show.digit(x[highlight.digits[i],], col=paste(substring(digits.col[label[highlight.digits[i]]], 1, 7), if (digits.alphas.reverse[i]) rev(alphas) else alphas, sep=""))})
	if (show.reconstructions) {
		sapply(seq_along(highlight.digits), function(i) {show.digit(reconstructions[highlight.digits[i],], col=paste(substring(digits.col[label[highlight.digits[i]]], 1, 7), if (digits.alphas.reverse[i]) rev(alphas) else alphas, sep=""))})
	}
	
	
	par(cex=cex, mar=c(3, 3, 0, 0), mgp=c(2, 1, 0))
	plot(predictions[, 1], predictions[, 2], xlab = xlab, ylab = ylab, xlim = xlim, ylim = ylim,
		 pch = pch, bg = pch.bg[label], col=pch.col[label], cex.axis=cex.axis, cex.lab=cex.lab)
	points(predictions[highlight.digits, 1], predictions[highlight.digits, 2], pch = pch, bg = pch.bg[label[highlight.digits]], col = pch.col[label[highlight.digits]], cex=cex.highlight)
	
	par(opar)
}

