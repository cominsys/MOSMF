function out = IsDominated( x, y )

    out=all(x<=y) && any(x<y);

end

